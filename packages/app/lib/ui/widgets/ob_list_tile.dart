import 'package:flutter/material.dart';

class OBListTile extends StatelessWidget {
  const OBListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.onTap,
    this.leading,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      leading: leading,
      onTap: onTap,
    );
  }
}
