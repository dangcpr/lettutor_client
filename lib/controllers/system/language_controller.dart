import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lettutor_client/l10n/ln10.dart';

class LanguageController {
  Future<Locale> getOption() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return Locale(pref.getString('locale') ?? 'vi');

    } catch (e) {
      SnackBar(content: Text(e.toString()));
      return const Locale('vi');
    } 
  }

  Future<void> changeLanguage(Locale newLocale) async {
    try {
      Locale locale;
      if(!L10n.all.contains(newLocale)) {
        locale = const Locale('en');
      } else {
        locale = newLocale;
      }

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('locale', locale.languageCode);
    } catch (e) {
      SnackBar(content: Text(e.toString()));
    }
  }
}