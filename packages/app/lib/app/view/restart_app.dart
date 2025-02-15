import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/app/routes/ob_router.dart';

class RestartWidget extends StatefulWidget {
  const RestartWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  static void restartApp(BuildContext context) {
    final state = context.findAncestorStateOfType<_RestartWidgetState>();

    if (state == null) {
      throw Exception(
        'RestartWidget.restartApp() called outside of RestartWidget',
      );
    }

    return state.restartApp();
  }

  @override
  State createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: RepositoryProvider(
        create: (context) => CustomRouter(),
        child: widget.child,
      ),
    );
  }
}
