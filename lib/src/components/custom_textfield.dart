import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.controlador, required this.label});
  final TextEditingController controlador;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controlador,
      decoration: InputDecoration(labelText: label),
    );
  }
}
