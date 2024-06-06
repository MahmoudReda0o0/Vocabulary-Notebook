import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';

abstract class ThemeManager {
  static ThemeData getThemeData() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: ColorManager.black,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.black,
        ),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: ColorManager.white),
      ),
    );
  }
}
