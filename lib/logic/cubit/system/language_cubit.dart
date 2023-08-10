import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_client/controllers/system/language_controller.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('vi'));

  void changeLocale(Locale option) => {
    LanguageController().changeLanguage(option),
    emit(option),
  };

  Future<void> loadOption() async => emit(await LanguageController().getOption());
}