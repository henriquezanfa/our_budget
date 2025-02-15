import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.autofocus = false,
    this.inputTextFormatters,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController? controller;
  final bool readOnly;
  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputTextFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      autofocus: autofocus,
      controller: controller,
      focusNode: focusNode,
      inputFormatters: inputTextFormatters,
      textInputAction: textInputAction,
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
