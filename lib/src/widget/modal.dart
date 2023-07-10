import 'package:flutter/material.dart';
import 'package:todo_app/src/src.dart';

class Modal extends StatelessWidget {
  final Map<String, TextEditingController> controllers;
  final int? id;
  final Future Function({int? id}) saveTask;
  const Modal(
      {Key? key,
      required this.id,
      required this.saveTask,
      required this.controllers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 30,
        left: 15,
        right: 15,
        bottom: MediaQuery.of(context).viewInsets.bottom + 50,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Text(
              id == null ? 'Create Task' : 'Update Task',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Input(
            text: 'Title',
            controller: controllers['title']!,
          ),
          const SizedBox(height: 10),
          Input(
            text: 'Description',
            maxLines: 3,
            controller: controllers['description']!,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onPressed: () async => id == null
                  ? await saveTask().then((_) => Navigator.pop(context))
                  : await saveTask(id: id).then((_) => Navigator.pop(context)),
              child: Text(
                id == null ? 'Create' : 'Update',
                style: const TextStyle(
                  color: Colors.black87,
                ),
              )),
        ],
      ),
    );
  }
}
