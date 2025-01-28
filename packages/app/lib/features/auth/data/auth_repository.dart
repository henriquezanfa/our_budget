import 'package:firebase_auth/firebase_auth.dart';

typedef UserId = String;

class AuthRepository {
  AuthRepository({required FirebaseAuth auth}) : _auth = auth;
  final FirebaseAuth _auth;

  User? get user => _auth.currentUser;

  Future<UserId> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credentials.user!.uid;
  }

  Future<UserId> signInAnonymously() async {
    final credentials = await _auth.signInAnonymously();
    return credentials.user!.uid;
  }
}
