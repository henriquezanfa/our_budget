import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/app/routes/ob_router.dart';
import 'package:ob/l10n/l10n.dart';
import 'package:ob/ui/ui.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final custom = context.read<CustomRouter>();
    return MaterialApp.router(
      theme: lightTheme,
      routerConfig: custom.router,
      darkTheme: darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return _CloseKeyboardWhenTouchingOutside(child: child!);
      },
    );
  }
}

class _CloseKeyboardWhenTouchingOutside extends StatelessWidget {
  const _CloseKeyboardWhenTouchingOutside({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
