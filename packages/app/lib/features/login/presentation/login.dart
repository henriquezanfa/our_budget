import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/features/login/bloc/login_bloc.dart';
import 'package:ob/ui/theme/ob_sizes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(OBSizes.screenPadding),
          child: BlocProvider(
            create: (context) => LoginBloc(FirebaseAuth.instance),
            child: const LoginView(),
          ),
        ),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? _email;
  String? _password;

  bool get _isFormValid => _email != null && _password != null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is LoginSuccess) {
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
                        context.read<LoginBloc>().add(
                              LoginSubmitted(_email!, _password!),
                            );
                      }
                    : null,
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.push(OBRoutes.registration);
                  },
                  child: const Text('Create an account'),
                ),
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
      'Login',
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

class OBTextField extends StatelessWidget {
  const OBTextField({
    required this.labelText,
    super.key,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
  });

  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}
