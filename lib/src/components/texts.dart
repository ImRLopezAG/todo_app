import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final int? maxLines;

  const Input({
    super.key,
    required this.text,
    required this.controller,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: text,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
