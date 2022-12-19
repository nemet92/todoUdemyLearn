import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todoudemy/model/task_model.dart';
import 'package:todoudemy/widget/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _allTasks;
  @override
  void initState() {
    _allTasks = <Task>[];
    _allTasks.add(Task.create(name: "Deneme", createdAt: DateTime.now()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              _showBottomAddTaskSheet(context);
            },
            child: const Text(
              "Bugun neler edecesin?",
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  _showBottomAddTaskSheet(context);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: _allTasks.isNotEmpty
            ? ListView.builder(
                itemCount: _allTasks.length,
                itemBuilder: (context, index) {
                  var oankiListeElemani = _allTasks[index];
                  return Dismissible(
                      background: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Gorev silindi")
                        ],
                      ),
                      onDismissed: ((direction) {
                        _allTasks.removeAt(index);
                        setState(() {});
                      }),
                      key: Key(oankiListeElemani.id),
                      child: TaskItem(
                        task: oankiListeElemani,
                      ));
                })
            : const Center(
                child: Text("Hadi gorev ekle"),
              ));
  }

  _showBottomAddTaskSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              title: TextField(
                autofocus: true,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                    hintText: "Task", border: InputBorder.none),
                onSubmitted: ((value) {
                  Navigator.of(context).pop();
                  if (value.length > 3) {
                    DatePicker.showTimePicker(
                      context,
                      showSecondsColumn: false,
                      onConfirm: (time) {
                        final yeniEklenecekGorev =
                            Task.create(name: value, createdAt: time);
                        _allTasks.add(yeniEklenecekGorev);
                        setState(() {});
                      },
                    );
                  }
                }),
              ),
            ),
          );
        });
  }
}
