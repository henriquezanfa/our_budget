import 'package:flutter/material.dart';
import 'package:ob/features/bank_accounts/presentation/ui/widgets/bank_accounts_list.dart';

class BankAccountsPage extends StatelessWidget {
  const BankAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BankAccountsList(),
      ],
    );
  }
}
