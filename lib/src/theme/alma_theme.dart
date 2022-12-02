import 'package:flutter/material.dart';

class AlmaTheme {
  static const Color primaryColor = Color(0xFF20386C);
  static const Color secondaryColor = Color(0xFFBF1E2E);
  static const Color actionColor = Color(0xFF3A89FF);
  static const Color greyAlmaColor = Color(0xFFEDEDED);
  static const Color blackAlmaColor = Color(0xFF282828);

  static ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      toolbarHeight: 80,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          //bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      )
    )
  );
}
