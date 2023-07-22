import 'package:flutter/material.dart';
import 'package:lettutor_client/l10n/ln10.dart';

class SystemProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  Locale _locale = const Locale('vi');

  bool get isDarkMode => _isDarkMode;

  Locale get locale => _locale;

  void changeOption() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void changeLocale(Locale newLocale) {
    if(!L10n.all.contains(newLocale)) return;
    _locale = newLocale;
    notifyListeners();
  }
}
