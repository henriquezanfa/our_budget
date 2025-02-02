import 'package:flutter/material.dart';

abstract class OBColors {
  static const Color primary = Color(0xFF011d2d);
  static const Color secondary = Color(0xFFf768be);
  static const Color tertiary = Color.fromARGB(59, 5, 162, 253);
  static const Color background = Color(0xFFf8f8fa);
  static const Color text = Color(0xFF011d2d);
}
 
class OBDarkColors extends OBColors {
  static const Color primary = Color.fromARGB(255, 9, 118, 181);
  static const Color secondary = Color.fromARGB(255, 86, 133, 161);
  static const Color background = Color(0xFF011d2d);
  static const Color text = Color(0xFFf8f8fa);
}
