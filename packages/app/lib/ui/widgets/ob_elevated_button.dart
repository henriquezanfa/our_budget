import 'package:flutter/material.dart';

class OBElevatedButton extends StatelessWidget {
  const OBElevatedButton({
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
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    final textColor = isDarkMode ? Colors.black : Colors.white;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
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
      ),
    );
  }
}
