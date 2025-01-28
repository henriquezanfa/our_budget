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
    on<ChangeSpace>(_onChangeSpace);
    on<InviteUser>(_onInviteUser);
    on<GetInvitations>(_onGetInvitations);
    on<ReplyToInvitation>(_onReplyToInvitation);
  }
  final SpaceRepository _spaceRepository;

  FutureOr<void> _onGetSpaces(
    GetSpaces event,
    Emitter<SpaceState> emit,
  ) async {
    emit(SpaceLoading());
    try {
      final spaces = await _spaceRepository.getSpaces();
      final currentSpace = await _spaceRepository.getCurrentSpace();
      emit(SpaceLoaded(spaces, currentSpace));
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

  FutureOr<void> _onGetInvitations(
    GetInvitations event,
    Emitter<SpaceState> emit,
  ) async {
    emit(SpaceLoading());
    try {
      if (event.email == null) {
        emit(InvitationsLoaded(const []));
        return;
      }
      final invitations = await _spaceRepository.getInvitedSpaces(event.email!);
      emit(InvitationsLoaded(invitations));
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }

  FutureOr<void> _onReplyToInvitation(
    ReplyToInvitation event,
    Emitter<SpaceState> emit,
  ) async {
    emit(SpaceLoading());
    try {
      await _spaceRepository.replyToInvitation(
        spaceId: event.spaceId,
        accept: event.accepted,
      );
      // emit(InvitationsLoaded(invitations));
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }

  FutureOr<void> _onChangeSpace(
    ChangeSpace event,
    Emitter<SpaceState> emit,
  ) async {
    emit(SpaceLoading());
    try {
      await _spaceRepository.changeSpace(event.spaceId);
      final currentSpace = await _spaceRepository.getCurrentSpace();
      emit(SpaceChanged(currentSpace));
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }
}
