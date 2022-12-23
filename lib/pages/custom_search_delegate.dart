import 'package:flutter/material.dart';
import 'package:todoudemy/data/local_stroage.dart';
import 'package:todoudemy/main.dart';
import 'package:todoudemy/model/task_model.dart';
import 'package:todoudemy/widget/task_list_item.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Task> allTask;

  CustomSearchDelegate({required this.allTask});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        close(context, null);
      }),
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Task> filteredList = allTask
        .where(
            (gorev) => gorev.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filteredList.isNotEmpty
        ? ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              var oankiListeElemani = filteredList[index];
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
                  onDismissed: ((direction) async {
                    filteredList.removeAt(index);
                    await locator<LocalStorage>()
                        .deleteTask(task: oankiListeElemani);
                  }),
                  key: Key(oankiListeElemani.id),
                  child: TaskItem(
                    task: oankiListeElemani,
                  ));
            })
        : const Center(
            child: Text("Axtardiginizi bulamadiq"),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
