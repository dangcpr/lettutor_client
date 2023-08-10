import 'package:lettutor_client/models/accounts.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Account account;
  LoginSuccess({required this.account});
}

class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}