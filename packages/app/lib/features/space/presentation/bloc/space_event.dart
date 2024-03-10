part of 'space_bloc.dart';

@immutable
sealed class SpaceEvent {}

class GetSpaces extends SpaceEvent {}

class GetCurrentSpace extends SpaceEvent {
  GetCurrentSpace();
}

class InviteUser extends SpaceEvent {
  InviteUser(this.email);
  final String email;
}
