import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ob/features/auth/data/auth_repository.dart';
import 'package:ob/features/space/data/space_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc(
    this._authRepository,
    this._spaceRepository,
  ) : super(RegistrationInitial()) {
    on<RegistrationSubmitted>(_onRegistrationSubmitted);
  }
  final AuthRepository _authRepository;
  final SpaceRepository _spaceRepository;

  FutureOr<void> _onRegistrationSubmitted(
    RegistrationSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());
    try {
      final userId = await _authRepository.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      await _spaceRepository.createSpace(userId, name: 'My Space');
      emit(RegistrationSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegistrationFailure(e.message ?? ''));
    } catch (e) {
      emit(RegistrationFailure(e.toString()));
    }
  }
}
