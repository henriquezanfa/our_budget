part of 'splash.dart';

bool _isInitialized = false;

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  if (!_isInitialized) {
    registerDependencies();
  }

  _isInitialized = true;
}
