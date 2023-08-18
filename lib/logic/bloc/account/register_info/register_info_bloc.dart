import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_client/controllers/account/accounts.dart';
import 'package:lettutor_client/logic/bloc/account/register_info/register_info_event.dart';
import 'package:lettutor_client/logic/bloc/account/register_info/register_info_state.dart';

class RegisterInfoBloc extends Bloc<RegisterInfoEvent, RegisterInfoState> {
  RegisterInfoBloc() : super(RegisterInfoInitial()) {
    on<RegisterInfoEvent>((event, emit) async {
      if(event is RegisterInfoPressed) {
        emit(RegisterInfoLoading());
        try {
          await AccountController().registerInfo(event.formData);
          emit(RegisterInfoSuccess(message: "Đăng ký thông tin thành công"));
        } catch (e) {
          emit(RegisterInfoError(message: e.toString()));
        }
      } else {
        emit(RegisterInfoInitial());
      }
    });
  }
}