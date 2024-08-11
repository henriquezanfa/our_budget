import 'package:flutter/material.dart';
import 'package:ob/ui/theme/ob_colors.dart';
import 'package:ob/ui/theme/ob_sizes.dart';

final _theme = ThemeData(
  fontFamily: 'Poppins',
);

final lightTheme = _theme.copyWith(
  colorScheme: const ColorScheme.light(
    primary: OBColors.primary,
    secondary: OBColors.secondary,
    background: OBColors.background,
  ),
  textTheme: _theme.textTheme.apply(
    bodyColor: OBColors.text,
    displayColor: OBColors.text,
  ),
  scaffoldBackgroundColor: OBColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: OBColors.background,
    foregroundColor: OBColors.primary,
 
    iconTheme: IconThemeData(
      color: OBColors.primary,
    ),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: OBColors.background,
    selectedItemColor: OBColors.primary,
    unselectedItemColor: OBColors.primary.withOpacity(0.5),
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: OBColors.background,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: OBSizes.medium,
      vertical: OBSizes.small,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: OBColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(OBSizes.medium),
      ),
      padding: const EdgeInsets.all(OBSizes.medium),
      textStyle: _theme.textTheme.titleLarge!.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  ),
  iconTheme: const IconThemeData(color: OBColors.primary),
  listTileTheme: const ListTileThemeData(iconColor: OBColors.primary),
);

final darkTheme = ThemeData(
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: OBDarkColors.background,
  colorScheme: const ColorScheme.dark(
    primary: OBDarkColors.primary,
    secondary: OBDarkColors.secondary,
    background: OBDarkColors.background,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: OBDarkColors.background,
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: OBDarkColors.background,
    selectedItemColor: OBDarkColors.primary,
    unselectedItemColor: OBDarkColors.primary.withOpacity(0.5),
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: OBDarkColors.background,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: OBSizes.medium,
      vertical: OBSizes.small,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: OBDarkColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(OBSizes.medium),
      ),
      textStyle: const TextStyle(
        color: OBDarkColors.text,
      ),
      padding: const EdgeInsets.all(OBSizes.medium),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: OBDarkColors.primary,
  ),
  iconTheme: const IconThemeData(color: OBDarkColors.primary),
  listTileTheme: const ListTileThemeData(
    iconColor: OBDarkColors.primary,
    contentPadding: EdgeInsets.symmetric(horizontal: OBSizes.small),
  ),
);
