import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class ManagePage extends StatelessWidget {
  const ManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ManagePageView();
  }
}

class ManagePageView extends StatelessWidget {
  const ManagePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return OBScreen.primary(
      title: 'Manage',
      slivers: [
        SliverToBoxAdapter(
          child: OBListTile(
            title: 'Bank Accounts',
            leading: const Icon(Icons.account_balance),
            onTap: () => context.push(OBRoutes.bankAccounts),
          ),
        ),
        const SliverToBoxAdapter(
          child: OBListTile(
            title: 'Credit Cards',
            leading: Icon(Icons.credit_card),
          ),
        ),
        const SliverToBoxAdapter(
          child: OBListTile(
            title: 'Goals',
            leading: Icon(Icons.account_balance_wallet),
          ),
        ),
        const SliverToBoxAdapter(
          child: OBListTile(
            title: 'Categories',
            leading: Icon(Icons.category),
          ),
        ),
        const SliverToBoxAdapter(
          child: OBListTile(
            title: 'Tags',
            leading: Icon(Icons.tag),
          ),
        ),
      ].withSpaceBetween(
        height: 16,
        isSliver: true,
      ),
    );
  }
}