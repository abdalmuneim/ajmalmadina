import 'package:flutter/material.dart';

import 'font_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    /// Main Color

    primaryColor: Colors.blue,
    primaryColorLight: Colors.lightBlue,
    primaryColorDark: Colors.blueGrey,
    disabledColor: Colors.grey,
    fontFamily: FontConstants.arabicFontFamily,

    /// CardViewTheme

    cardTheme: const CardTheme(
        color: Colors.white, shadowColor: Colors.grey, elevation: AppSize.s4),

    /// AppBar Theme

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.green,
      elevation: AppSize.s4,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
        fontFamily: FontConstants.arabicFontFamily,
        fontSize: FontSize.s24,
        fontWeight: FontWeightManager.regular,
        color: Colors.white,
      ),
    ),

    /// Button Theme

    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: Colors.grey,
      buttonColor: Colors.blue,
      splashColor: Colors.lightBlue,
    ),

    /// text style
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
      fontSize: FontSize.s18,
    )),

    /// Elevated Button Theme

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontFamily: FontConstants.arabicFontFamily,
            fontSize: FontSize.s20,
            fontWeight: FontWeightManager.regular,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12))),
    ),
  );
}
