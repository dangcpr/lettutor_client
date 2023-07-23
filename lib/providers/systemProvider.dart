import 'package:flutter/material.dart';
import 'package:lettutor_client/l10n/ln10.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemProvider extends ChangeNotifier {
  int _isDarkMode = 0;
  Locale _locale = const Locale('vi');

  int get isDarkMode => _isDarkMode;
  Locale get locale => _locale;

  Future<void> changeOption(int newDarkMode) async {
    try {
      _isDarkMode = newDarkMode;
      
      SharedPreferences pref= await SharedPreferences.getInstance();
      pref.setInt('darkMode', _isDarkMode);

      notifyListeners();
    } catch (e) {
      SnackBar(content: Text(e.toString()));
    }
  }

  Future<void> changeLocale(Locale newLocale) async {
    try {
      if(!L10n.all.contains(newLocale)) {
        _locale = const Locale('en');
      } else {
        _locale = newLocale;
      }

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('locale', _locale.languageCode);

      notifyListeners();
    } catch (e) {
      SnackBar(content: Text(e.toString()));
    }
  }

  Future<void> loadOption() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      _isDarkMode = pref.getInt('darkMode') ?? 0;
      _locale = Locale(pref.getString('locale') ?? 'vi');
      notifyListeners();
    } catch (e) {
      SnackBar(content: Text(e.toString()));
    } 
  }
}
