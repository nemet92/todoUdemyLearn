import 'package:easy_localization/easy_localization.dart';
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
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("remove_task").tr()
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
        : Center(
            child: const Text('search_not_found').tr(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
