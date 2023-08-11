import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_client/controllers/account/accounts.dart';
import 'package:lettutor_client/logic/bloc/account/resend_email_verified/resend_email_event.dart';
import 'package:lettutor_client/logic/bloc/account/resend_email_verified/resend_email_state.dart';

class ResendEmailBloc extends Bloc<ResendEmailEvent, ResendEmailState> {
  ResendEmailBloc() : super(ResendEmailInitial()) {
    on<ResendEmailEvent>((event, emit) async {
      if(event is ResendEmailPressed) {
        emit(ResendEmailLoading());
        try {
          final result = await AccountController().resendEmailVerified(event.email);
          emit(ResendEmailSuccess(message: result));
        } catch (e) {
          emit(ResendEmailError(message: e.toString()));
        }
      }
    });
  }
}