part of 'space_bloc.dart';

@immutable
sealed class SpaceState {}

final class SpaceInitial extends SpaceState {}

final class SpaceLoading extends SpaceState {}

final class SpaceLoaded extends SpaceState {
  SpaceLoaded(this.spaces, this.currentSpace);
  final List<SpaceModel> spaces;
  final SpaceModel? currentSpace;
}

final class SpaceError extends SpaceState {
  SpaceError(this.message);
  final String message;
}

final class UserInvited extends SpaceState {}

final class InvitationsLoaded extends SpaceState {
  InvitationsLoaded(this.invitations);
  final List<SpaceModel> invitations;
}

final class SpaceChanged extends SpaceState {
  SpaceChanged(this.space);
  final SpaceModel space;
}
