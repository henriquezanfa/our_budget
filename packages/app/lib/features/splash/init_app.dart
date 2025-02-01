part of 'splash.dart';

bool _isInitialized = false;

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode && !_isInitialized) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  await inject.reset();
  await registerDependencies();

  _isInitialized = true;
}
