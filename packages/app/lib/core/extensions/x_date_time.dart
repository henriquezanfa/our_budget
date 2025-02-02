import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ob/l10n/l10n.dart';

extension XDateTime on DateTime {
  String yMd(BuildContext context) {
    final f = DateFormat.yMd(context.l10n.localeName);
    return f.format(this);
  }
}
