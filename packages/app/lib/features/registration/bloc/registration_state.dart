part of 'registration_bloc.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoading extends RegistrationState {}

final class RegistrationSuccess extends RegistrationState {}

final class RegistrationFailure extends RegistrationState {
  RegistrationFailure(this.message);
  final String message;
}
