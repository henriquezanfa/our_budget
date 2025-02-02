import 'package:flutter/material.dart';

class OBListTile extends StatelessWidget {
  const OBListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.onTap,
    this.leading,
    this.trailing,
    this.showBorder = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      minLeadingWidth: 0,
      subtitle: subtitle != null ? Text(subtitle!) : null,
      leading: leading,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      trailing: trailing,
      onTap: onTap,
      shape: showBorder
          ? RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
    );
  }
}
