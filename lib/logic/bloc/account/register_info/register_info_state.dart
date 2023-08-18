abstract class RegisterInfoState {}

class RegisterInfoInitial extends RegisterInfoState {}

class RegisterInfoLoading extends RegisterInfoState {}

class RegisterInfoSuccess extends RegisterInfoState {
  final String message;
  RegisterInfoSuccess({required this.message});
}

class RegisterInfoError extends RegisterInfoState {
  final String message;
  RegisterInfoError({required this.message});
}