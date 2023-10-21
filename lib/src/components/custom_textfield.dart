import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controlador,
      required this.label,
      required this.keyboardType});
  final TextEditingController controlador;
  final String label;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controlador,
      decoration: InputDecoration(labelText: label),
    );
  }
}
