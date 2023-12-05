import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/bank_accounts/presentation/bloc/bank_account_bloc.dart';
import 'package:ob/features/bank_accounts/presentation/ui/widgets/bank_accounts_list.dart';
import 'package:ob/features/bank_accounts/presentation/ui/widgets/create_bank_account.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BankAccountBloc(inject())..add(GetBankAccounts()),
      child: const AccountsPageView(),
    );
  }
}

class AccountsPageView extends StatelessWidget {
  const AccountsPageView({super.key});

  void _onRefresh(BuildContext context) {
    BlocProvider.of<BankAccountBloc>(context).add(GetBankAccounts());
  }

  @override
  Widget build(BuildContext context) {
    return OBScreen.primary(
      title: 'Accounts and Cards',
      onRefresh: () => _onRefresh(context),
      actions: [
        CreateBankAccount.icon(),
      ],
      slivers: [
        const SliverToBoxAdapter(child: BankAccountsList()),
      ].withSpaceBetween(
        height: 16,
        isSliver: true,
      ),
    );
  }
}
