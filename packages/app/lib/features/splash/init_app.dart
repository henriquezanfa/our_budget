part of 'splash.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
}
