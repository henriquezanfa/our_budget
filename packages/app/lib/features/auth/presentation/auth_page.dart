import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    _handleUser(user);
  }

  void _handleUser(User? user) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        context.go(OBRoutes.login);
      } else {
        context.go(OBRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
