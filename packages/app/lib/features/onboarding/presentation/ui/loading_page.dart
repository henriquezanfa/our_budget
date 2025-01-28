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
  final List<String> _items = [
    'Setting up your account',
    'Creating your space',
    'Setting up bank account',
    'Creating categories',
  ];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _sendDataToDatabase();

    Future<void>.delayed(const Duration(milliseconds: 4200), () {
      if (context.mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _sendDataToDatabase() async {
    await context.read<OnboardingCubit>().saveData();
    await Future<void>.delayed(const Duration(seconds: 2));

    // if (context.mounted) context.go(OBRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'We are almost there!',
                      style: theme.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Just a few more steps to get you started on your budgeting journey.',
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    AnimatedItem(
                      text: _items[0],
                      duration: const Duration(milliseconds: 1000),
                    ),
                    AnimatedItem(
                      text: _items[1],
                      duration: const Duration(milliseconds: 1900),
                    ),
                    AnimatedItem(
                      text: _items[2],
                      duration: const Duration(milliseconds: 3200),
                    ),
                    AnimatedItem(
                      text: _items[3],
                      duration: const Duration(milliseconds: 4000),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isLoading ? 0 : 1,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go(OBRoutes.home);
                    },
                    child: const Text('Get started'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedItem extends StatefulWidget {
  const AnimatedItem({
    required this.text,
    super.key,
    this.duration = const Duration(milliseconds: 500),
  });
  final String text;
  final Duration duration;

  @override
  State<AnimatedItem> createState() => _AnimatedItemState();
}

class _AnimatedItemState extends State<AnimatedItem> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.duration, () {
      if (context.mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
          ),
          const SizedBox(width: 20),
          Text(widget.text),
        ],
      ),
    );
  }
}
