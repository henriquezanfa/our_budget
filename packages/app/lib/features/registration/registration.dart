import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/features/registration/bloc/registration_bloc.dart';
import 'package:ob/ui/theme/ob_sizes.dart';
import 'package:ob/ui/widgets/widgets.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(OBSizes.screenPadding),
          child: BlocProvider(
            create: (context) => RegistrationBloc(FirebaseAuth.instance),
            child: const Forms(),
          ),
        ),
      ),
    );
  }
}

class Forms extends StatefulWidget {
  const Forms({
    super.key,
  });

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  String? _email;
  String? _password;

  bool get _isFormValid => _email != null && _password != null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is RegistrationSuccess) {
          context.go('/home');
        }
      },
      builder: (context, state) {
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Title(),
              const SizedBox(height: 16),
              LoginEmailField(
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              LoginPasswordField(
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              LoginButton(
                onPressed: _isFormValid
                    ? () {
                        context.read<RegistrationBloc>().add(
                              RegistrationSubmitted(_email!, _password!),
                            );
                      }
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Registration',
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({
    required this.onChanged,
    super.key,
  });
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return OBTextField(
      labelText: 'Email',
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
    );
  }
}

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({
    required this.onChanged,
    super.key,
  });
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return OBTextField(
      labelText: 'Password',
      obscureText: true,
      onChanged: onChanged,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    this.onPressed,
    super.key,
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text('Login'),
      ),
    );
  }
}
