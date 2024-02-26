import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/theme/custom_themes/appbar_theme.dart';
import 'package:queue_ease/src/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:queue_ease/src/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:queue_ease/src/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:queue_ease/src/utils/theme/custom_themes/text_field_theme.dart';
import 'package:queue_ease/src/utils/theme/custom_themes/text_theme.dart';

class QEAppTheme {
  QEAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: QETextTheme.lightTextTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: QEAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: QEBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: QEElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: QEOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: QETextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: QETextTheme.darkTextTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: QEAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: QEBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: QEElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: QEOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: QETextFormFieldTheme.darkInputDecorationTheme,
  );
}
