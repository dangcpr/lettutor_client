import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeController {
  Future<int> getOption() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getInt('darkMode') ?? 0;

    } catch (e) {
      SnackBar(content: Text(e.toString()));
      return 0;
    } 
  }

  Future<void> changeDarkMode(int newDarkMode) async {
    try {
      SharedPreferences pref= await SharedPreferences.getInstance();
      pref.setInt('darkMode', newDarkMode);
    } catch (e) {
      SnackBar(content: Text(e.toString()));
    }
  }
}