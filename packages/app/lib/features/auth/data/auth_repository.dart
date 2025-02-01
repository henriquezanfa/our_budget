import 'package:firebase_auth/firebase_auth.dart';

typedef UserId = String;

class AuthRepository {
  AuthRepository({required FirebaseAuth auth}) : _auth = auth;
  final FirebaseAuth _auth;

  User? get user => _auth.currentUser;
  bool get isAuthenticated => user != null;
  bool get isAnonymous => user?.isAnonymous ?? false;

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

  Future<void> convertToPermanentAccount({
    required String email,
    required String password,
  }) async {
    final user = _auth.currentUser;
    final credentials = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await user!.linkWithCredential(credentials);
  }
}
