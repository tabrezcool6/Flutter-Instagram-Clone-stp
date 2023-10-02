import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final String hintText;
  // final String validateValue;

  const InputTextField({
    Key? key,
    required this.controller,
    required this.inputType,
    required this.hintText,
    // required this.validateValue,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final outlineInputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Invalid $hintText';
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8.0),
        filled: true,
        hintText: hintText,
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
      ),
    );
  }
}
