import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';

class AuthHandlerPage extends StatefulWidget {
  const AuthHandlerPage({super.key});

  @override
  State<AuthHandlerPage> createState() => _AuthHandlerPageState();
}

class _AuthHandlerPageState extends State<AuthHandlerPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      bool isAuthenticated = true;

      if (isAuthenticated) {
        context.go(OBRoutes.home);
      } else {
        context.go(OBRoutes.login);
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
