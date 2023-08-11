import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_client/controllers/account/accounts.dart';
import 'package:lettutor_client/logic/bloc/account/login/login_event.dart';
import 'package:lettutor_client/logic/bloc/account/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if(event is LoginButtonPressed) {
        emit(LoginLoading());
        try {
          final result = await AccountController().login(event.email, event.password);
          debugPrint('2');
          emit(LoginSuccess(account: result));
        } catch (e) {
          debugPrint(e.toString());
          emit(LoginError(message: e.toString()));
        }
      } else {
        emit(LoginInitial());
      }
    });
  }
}