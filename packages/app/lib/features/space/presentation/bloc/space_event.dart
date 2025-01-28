part of 'space_bloc.dart';

@immutable
sealed class SpaceEvent {}

class GetSpaces extends SpaceEvent {}

class ChangeSpace extends SpaceEvent {
  ChangeSpace(this.spaceId);
  final String spaceId;
}

class InviteUser extends SpaceEvent {
  InviteUser(this.email);
  final String email;
}

class GetInvitations extends SpaceEvent {
  GetInvitations(this.email);
  final String? email;
}

class ReplyToInvitation extends SpaceEvent {
  ReplyToInvitation(
    this.spaceId, {
    required this.accepted,
  });
  final String spaceId;
  final bool accepted;
}
