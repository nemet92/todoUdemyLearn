import 'package:flutter/material.dart';
import 'package:todoudemy/model/task_model.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(8), blurRadius: 10)
          ]),
      child: ListTile(
        leading: GestureDetector(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                    color:
                        widget.task.isCompleted ? Colors.green : Colors.white),
                child: const Icon(Icons.check))),
        title: Text(widget.task.name),
      ),
    );
  }
}
