import 'package:flutter/material.dart';

class CardTask extends StatelessWidget {
  final String title;
  final String description;
  final bool isDone;
  final Function onDelete;
  final Function onEdit;
  final Function onDone;
  const CardTask(
      {Key? key,
      required this.title,
      required this.description,
      required this.isDone,
      required this.onDelete,
      required this.onEdit,
      required this.onDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: Colors.white,
      child: ListTile(
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        subtitle: Text(description),
        onTap: () => onDone(),
        onLongPress: () => onDelete(),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: isDone,
              onChanged: (value) => onDone(),
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            IconButton(
              onPressed: () => onEdit(),
              icon: const Icon(Icons.edit_note_rounded, color: Colors.blue),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () => onDelete(),
              icon: const Icon(Icons.delete_rounded, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
