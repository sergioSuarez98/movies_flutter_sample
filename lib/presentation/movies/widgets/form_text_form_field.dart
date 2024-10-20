import 'package:flutter/material.dart';

class FormTextFormField extends StatelessWidget {
  String? initialValue;
  final String labelText;
  final String? Function(String?) validator;
  final TextInputType? inputType;
  final TextEditingController controller;
  FormTextFormField({
    super.key,
    this.initialValue,
    required this.labelText,
    required this.validator,
    required this.inputType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: labelText),
      validator: validator,
      onChanged: (newValue) => controller.text = newValue,
      keyboardType: inputType,
    );
  }
}
