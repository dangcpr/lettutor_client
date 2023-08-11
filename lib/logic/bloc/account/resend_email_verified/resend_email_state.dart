abstract class ResendEmailState {}

class ResendEmailInitial extends ResendEmailState {}

class ResendEmailLoading extends ResendEmailState {}

class ResendEmailSuccess extends ResendEmailState {
  final int message;
  ResendEmailSuccess({required this.message});
}

class ResendEmailError extends ResendEmailState {
  final String message;
  ResendEmailError({required this.message});
}