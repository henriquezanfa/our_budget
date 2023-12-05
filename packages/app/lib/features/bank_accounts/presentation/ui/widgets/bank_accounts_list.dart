import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/features/bank_accounts/presentation/bloc/bank_account_bloc.dart';

class BankAccountsList extends StatelessWidget {
  const BankAccountsList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BankAccountBloc, BankAccountState>(
      listener: (context, state) {
        if (state is BankAccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.userMessage),
            ),
          );
        }

        if (state is BankAccountAdded) {
          BlocProvider.of<BankAccountBloc>(context).add(GetBankAccounts());
        }
      },
      builder: (context, state) {
        if (state is BankAccountInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BankAccountLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.bankAccounts.length,
            itemBuilder: (context, index) {
              final bankAccount = state.bankAccounts[index];
              return ListTile(
                title: Text(bankAccount.name),
                subtitle: Text(bankAccount.accountType.name),
              );
            },
          );
        } else if (state is NoBankAccount) {
          return const Center(
            child: Text('No bank account'),
          );
        } else if (state is BankAccountError) {
          return Center(
            child: Text(state.error.userMessage),
          );
        } else {
          return const Offstage();
        }
      },
    );
  }
}
