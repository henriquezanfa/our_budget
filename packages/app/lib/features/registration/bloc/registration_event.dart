part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

final class RegistrationSubmitted extends RegistrationEvent {
  RegistrationSubmitted(this.email, this.password);
  final String email;
  final String password;
}
