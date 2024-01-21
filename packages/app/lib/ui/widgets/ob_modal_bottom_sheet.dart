import 'package:flutter/material.dart';

Future<T?> showOBModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool? showDragHandle = true,
}) {
  return showModalBottomSheet<T>(
    useRootNavigator: true,
    isScrollControlled: true,
    showDragHandle: showDragHandle,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) => SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: child,
      ),
    ),
  );
}
