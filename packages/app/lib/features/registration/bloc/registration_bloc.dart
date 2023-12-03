import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc(this._firebaseAuth) : super(RegistrationInitial()) {
    on<RegistrationSubmitted>(_onRegistrationSubmitted);
  }
  final FirebaseAuth _firebaseAuth;

  FutureOr<void> _onRegistrationSubmitted(
    RegistrationSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(RegistrationSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegistrationFailure(e.message ?? ''));
    }
  }
}
