import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _sendDataToDatabase();
  }

  Future<void> _sendDataToDatabase() async {
    await context.read<OnboardingCubit>().saveData();
    await Future<void>.delayed(const Duration(seconds: 2));

    if (context.mounted) context.go(OBRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              'Creating workspace...',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Creating bank accounts...',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Adding categories...',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
