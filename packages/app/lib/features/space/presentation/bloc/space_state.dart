part of 'space_bloc.dart';

@immutable
sealed class SpaceState {}

final class SpaceInitial extends SpaceState {}

final class SpaceLoading extends SpaceState {}

final class SpaceLoaded extends SpaceState {
  SpaceLoaded(this.spaces);
  final List<SpaceModel> spaces;
}

final class SpaceError extends SpaceState {
  SpaceError(this.message);
  final String message;
}

final class CurrentSpace extends SpaceState {
  CurrentSpace(this.space);
  final SpaceModel space;
}

final class UserInvited extends SpaceState {}
