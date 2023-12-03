import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/ui/widgets/widgets.dart';

class AppWithNavbar extends StatelessWidget {
  const AppWithNavbar({
    required this.child,
    super.key,
  });
  final StatefulNavigationShell child;

  void _goBranch(int index) {
    child.goBranch(
      index,
      initialLocation: index == child.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: OBBottomAppBar(
        currentIndex: child.currentIndex,
        onTabPress: _goBranch,
        items: const [
          Icon(Icons.home_outlined),
          Icon(Icons.history_outlined),
          Icon(Icons.credit_card_outlined),
          Icon(Icons.person_outline),
        ],
      ),
    );
  }
}
