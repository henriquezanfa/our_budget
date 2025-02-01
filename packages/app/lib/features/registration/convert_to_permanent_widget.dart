import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/auth/data/auth_repository.dart';

class ConvertToPermanentWidget extends StatelessWidget {
  const ConvertToPermanentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = inject.get<AuthRepository>();
    final isAnonymous = auth.isAnonymous;

    if (!isAnonymous) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () {
        context.push(OBRoutes.registration);
      },
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create an account', style: theme.textTheme.titleMedium),
              const Text(
                'You have signed up with a temporary account. In order to share a space with another person, you have to create your account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
