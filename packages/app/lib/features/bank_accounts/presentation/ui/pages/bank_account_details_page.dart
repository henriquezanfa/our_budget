import 'package:flutter/material.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';
import 'package:ob/features/bank_accounts/presentation/ui/widgets/bank_account_details_widget.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class BankAccountDetailsPage extends StatelessWidget {
  const BankAccountDetailsPage({
    required this.bankAccount,
    super.key,
  });
  final BankAccount bankAccount;

  @override
  Widget build(BuildContext context) {
    return OBScreen.secondary(
      title: 'Bank Account Details',
      children: [
        SliverToBoxAdapter(
          child: BankAccountDetailsWidget(bankAccount: bankAccount),
        ),
      ].withSpaceBetween(
        height: 16,
        isSliver: true,
      ),
    );
  }
}
