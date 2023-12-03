part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginSubmitted extends LoginEvent {
  LoginSubmitted(this.email, this.password);
  final String email;
  final String password;
}
