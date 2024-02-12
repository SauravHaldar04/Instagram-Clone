import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isPass;
  final String hintText;

  const TextFieldInput(
      {super.key,
      required this.controller,
      required this.textInputType,
      required this.hintText,
      this.isPass = false});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      obscureText: isPass,
      keyboardType: textInputType,
      decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
    );
  }
}
