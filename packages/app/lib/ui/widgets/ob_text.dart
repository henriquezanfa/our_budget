import 'package:flutter/material.dart';

class OBTextField extends StatelessWidget {
  const OBTextField({
    required this.labelText,
    this.controller,
    super.key,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType,
    this.focusNode,
    this.onChanged,
    this.onTap,
  });

  final TextEditingController? controller;
  final bool readOnly;
  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}