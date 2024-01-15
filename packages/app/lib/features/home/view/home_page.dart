import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/features/balance/presentation/balance_widget.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return OBScreen.primary(
      title: 'Hello, there 👋',
      slivers: [
        const SliverToBoxAdapter(
          child: BalanceWidget(),
        ),
        SliverToBoxAdapter(
          child: OBElevatedButton(
            text: 'New transaction',
            onPressed: () {
              context.push(OBRoutes.addTransaction);
            },
          ),
        ),
      ].withSpaceBetween(
        height: 16,
        isSliver: true,
      ),
    );
  }
}
