import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String get ydm => DateFormat('yyyy-MM-dd').format(this);
}
