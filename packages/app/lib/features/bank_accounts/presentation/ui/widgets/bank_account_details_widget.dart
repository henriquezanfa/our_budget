import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';
import 'package:ob/features/bank_accounts/presentation/bloc/bank_account_bloc.dart';
import 'package:ob/features/bank_accounts/presentation/ui/widgets/bank_account_information_widget.dart';
import 'package:ob/features/bank_accounts/presentation/ui/widgets/bank_account_members.dart';

class BankAccountDetailsWidget extends StatelessWidget {
  const BankAccountDetailsWidget({
    required this.bankAccount,
    super.key,
  });
  final BankAccount bankAccount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BankAccountBloc(inject()),
      child: BankAccountDetailsView(
        bankAccount: bankAccount,
      ),
    );
  }
}

class BankAccountDetailsView extends StatefulWidget {
  const BankAccountDetailsView({
    required this.bankAccount,
    super.key,
  });

  final BankAccount bankAccount;

  @override
  State<BankAccountDetailsView> createState() =>
      _BankAccountDetailsWidgetState();
}

class _BankAccountDetailsWidgetState extends State<BankAccountDetailsView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<BankAccountBloc, BankAccountState>(
      listener: (context, state) {
        if (state is BankAccountMemberInvited) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Member invited'),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BankAccountInformationWidget(bankAccount: widget.bankAccount),
          const SizedBox(height: 32),
          Text(
            'Members',
            style: theme.textTheme.headlineSmall,
          ),
          BankAccountMembersWidget(
            accountMembers: widget.bankAccount.members,
            bankAccountId: widget.bankAccount.id,
          ),
        ],
      ),
    );
  }
}
