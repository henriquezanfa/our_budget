import 'package:flutter/material.dart';

Future<void> showInfoToast(BuildContext context, String message) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

Future<void> showSuccessToast(BuildContext context, String message) async {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: theme.colorScheme.secondary,
    ),
  );
}

Future<void> showErrorToast(BuildContext context, String message) async {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: theme.colorScheme.error,
    ),
  );
}
