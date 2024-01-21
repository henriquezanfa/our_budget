part of 'splash.dart';

bool _isInitialized = false;

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  if (!_isInitialized) {
    registerDependencies();
  }

  _isInitialized = true;
}
