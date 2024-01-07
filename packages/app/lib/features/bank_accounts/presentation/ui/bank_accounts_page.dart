import 'package:flutter/material.dart';
import 'package:ob/features/bank_accounts/presentation/ui/pages/bank_accounts_list_page.dart';

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
