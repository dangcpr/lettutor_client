import 'package:flutter/material.dart';
import 'package:lettutor_client/constants/colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'GoogleSans-Regular',
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    shadowColor: Colors.transparent,
    backgroundColor: colorProject.lightColor,
    foregroundColor: Colors.black,
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    labelMedium: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      color: colorProject.lightColor,
      fontSize: 14
    ),
    bodyMedium: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      fontSize: 14
    ),
    headlineMedium: TextStyle(
      fontFamily: 'GoogleSans-Bold',
      color: colorProject.lightColor,
      fontSize: 26
    )
  ),
  switchTheme: SwitchThemeData(
    overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent),
    splashRadius: 20,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    textStyle: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      fontSize: 14
    ),
  ),
  //cursor
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: colorProject.lightColor,
    selectionHandleColor: colorProject.lightColor
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid, 
        color: colorProject.lightColor
      ),
    ),
    labelStyle: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      fontSize: 14,
    ),
    floatingLabelStyle: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      color: colorProject.lightColor,
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
      backgroundColor: MaterialStateProperty.all(colorProject.lightColor),
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
    color: colorProject.lightColor,
    size: 40,
  ),
);