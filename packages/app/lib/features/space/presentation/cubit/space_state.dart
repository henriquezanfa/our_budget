part of 'space_cubit.dart';

@immutable
class SpaceState {
  const SpaceState._(
    this.currentSpace,
    this.error,
  );

  const SpaceState.initial() : this._(null, null);

  const SpaceState.error(String error) : this._(null, error);

  const SpaceState.loaded(SpaceModel currentSpace) : this._(currentSpace, null);

  final SpaceModel? currentSpace;
  final String? error;
}
