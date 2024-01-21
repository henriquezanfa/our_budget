import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String get ydm => DateFormat().add_yMd().format(this);

  String get ymdhms => DateFormat().add_yMd().add_Hms().format(this);

  String get yMMM => DateFormat().add_yMMM().format(this);
}
