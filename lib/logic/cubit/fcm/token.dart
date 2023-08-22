import 'package:flutter_bloc/flutter_bloc.dart';

class FCMTokenCubit extends Cubit<String?> {
  FCMTokenCubit() : super(null);

  void setToken(String? token) {
    emit(token);
  }
}