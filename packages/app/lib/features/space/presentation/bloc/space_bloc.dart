import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/features/space/data/space_repository.dart';
import 'package:ob/features/space/domain/space_model.dart';

part 'space_event.dart';
part 'space_state.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  SpaceBloc(this._spaceRepository) : super(SpaceInitial()) {
    on<GetSpaces>(_onGetSpaces);
    on<GetCurrentSpace>(_onGetCurrentSpace);
    on<InviteUser>(_onInviteUser);
  }
  final SpaceRepository _spaceRepository;

  FutureOr<void> _onGetSpaces(
    GetSpaces event,
    Emitter<SpaceState> emit,
  ) async {
    emit(SpaceLoading());
    try {
      final spaces = await _spaceRepository.getSpaces();
      emit(SpaceLoaded(spaces));
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }

  FutureOr<void> _onGetCurrentSpace(
    GetCurrentSpace event,
    Emitter<SpaceState> emit,
  ) async {
    try {
      final currentSpace = await _spaceRepository.getCurrentSpace();
      emit(CurrentSpace(currentSpace));
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }

  FutureOr<void> _onInviteUser(
    InviteUser event,
    Emitter<SpaceState> emit,
  ) async {
    emit(SpaceLoading());
    try {
      await _spaceRepository.inviteUserToSpace(event.email);

      emit(UserInvited());
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }
}
