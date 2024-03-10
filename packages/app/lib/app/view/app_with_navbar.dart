import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/view/ob_fab.dart';
import 'package:ob/ui/widgets/widgets.dart';

class AppWithNavbar extends StatelessWidget {
  const AppWithNavbar({
    required this.child,
    super.key,
  });
  final StatefulNavigationShell child;

  void _goBranch(int index) {
    final effectiveIndex = index > 2 ? index - 1 : index;
    final effectiveCurrentIndex = child.currentIndex;

    child.goBranch(
      effectiveIndex,
      initialLocation: effectiveIndex == effectiveCurrentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveCurrentIndex =
        child.currentIndex > 1 ? child.currentIndex + 1 : child.currentIndex;

    return Scaffold(
      body: child,
      bottomNavigationBar: OBBottomAppBar(
        currentIndex: effectiveCurrentIndex,
        onTabPress: _goBranch,
        items: const [
          Icon(Icons.home_outlined),
          Icon(Icons.history_outlined),
          ObFab(),
          Icon(Icons.credit_card_outlined),
          Icon(Icons.person_outline),
        ],
      ),
    );
  }
}
