import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String label;
  final TextInputType textInputType;
  final TextEditingController controller;
  const Textfield(
      {super.key,
      required this.label,
      required this.textInputType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 6),
          ),
          label: Text(label),
        ),
        keyboardType: textInputType,
        controller: controller,

        // Set focus change listener
      ),
    );
  }
}
