import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';

class ObFab extends StatelessWidget {
  const ObFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.push(OBRoutes.addTransaction);
      },
      elevation: 1,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
