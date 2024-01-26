import 'package:flutter/material.dart';

class OBTextButton extends StatelessWidget {
  const OBTextButton({
    required this.text,
    super.key,
    this.onPressed,
    this.isLoading = false,
  });
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor = theme.colorScheme.primary;

    return TextButton(
      onPressed: onPressed,
      child: isLoading
          ? const SizedBox(
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              style: TextStyle(color: textColor),
            ),
    );
  }
}
