import 'package:flutter/material.dart';
import 'package:lettutor_client/constants/colors.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: colorProject.darkColor,
  fontFamily: 'GoogleSans-Regular',
  brightness: Brightness.dark,
  useMaterial3: true,
  textTheme: const TextTheme(
    labelMedium: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      color: colorProject.darkColor,
      fontSize: 14
    ),
    bodyMedium: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      fontSize: 14
    ),
    headlineMedium: TextStyle(
      fontFamily: 'GoogleSans-Bold',
      color: colorProject.darkColor,
      fontSize: 26
    ),
    headlineLarge: TextStyle(
      fontFamily: 'GoogleSans-Bold',
      color: colorProject.darkColor,
      fontSize: 34
    ),
    headlineSmall: TextStyle(
      fontFamily: 'GoogleSans-Bold',
      fontSize: 20
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(Colors.white),
    trackColor: MaterialStateProperty.all(colorProject.darkColor),
    overlayColor: MaterialStateProperty.all(colorProject.darkColor),
    splashRadius: 20,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: colorProject.darkColor,
    selectionHandleColor: colorProject.darkColor
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid, 
        color: colorProject.darkColor
      ),
    ),
    labelStyle: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      fontSize: 14,
    ),
    floatingLabelStyle: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      color: colorProject.darkColor,
      fontSize: 14,
    ),
    hintStyle: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      fontSize: 14,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(const Size(600, 50)),
      backgroundColor: MaterialStateProperty.all(colorProject.darkColor),
      foregroundColor: MaterialStateProperty.all(colorProject.white),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontFamily: 'GoogleSans-Bold',
          fontSize: 20,
        )
      ),
    ),
  ),
  iconTheme: IconThemeData(
    color: colorProject.darkColor,
    size: 40,
  ),
);