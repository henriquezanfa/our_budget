import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/features/transactions/presentation/bloc/transactions_bloc.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsBloc(
        inject.get(),
        inject.get(),
        inject.get(),
      )..add(GetTransactions()),
      child: const _TransactionsListView(),
    );
  }
}

class _TransactionsListView extends StatelessWidget {
  const _TransactionsListView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        var transactions = <MoneyTransaction>[];

        if (state is TransactionsLoaded) {
          transactions = state.transactions;
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];

            return ListTile(
              title: Text(transaction.description ?? ''),
              subtitle: Text(transaction.amount.toString()),
            );
          },
        );
      },
    );
  }
}
