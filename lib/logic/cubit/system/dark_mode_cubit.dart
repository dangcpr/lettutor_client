import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_client/controllers/system/dark_mode_controller.dart';

class DarkModeCubit extends Cubit<int> {
  DarkModeCubit() : super(0);

  void changeTheme(int option) => {
    DarkModeController().changeDarkMode(option),
    emit(option),
  };
  
  Future<void> loadOption() async => emit(await DarkModeController().getOption());
}