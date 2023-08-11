abstract class ResendEmailEvent {}

class ResendEmailPressed extends ResendEmailEvent {
  final String email;

  ResendEmailPressed({required this.email});
}