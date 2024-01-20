import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:ob/ui/extensions/date_extensions.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/extensions/number_extensions.dart';

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
              trailing: TransactionValueWidget(transaction: transaction),
              subtitle: Text(transaction.date.ymdhms),
            );
          },
        );
      },
    );
  }
}

class TransactionValueWidget extends StatelessWidget {
  const TransactionValueWidget({
    required this.transaction,
    super.key,
  });

  final MoneyTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final type = transaction.type;
    final textTheme = Theme.of(context).textTheme.bodyMedium;

    if (type == MoneyTransactionType.income) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(transaction.amount.currency, style: textTheme),
          const Icon(Icons.arrow_upward, color: Colors.green),
        ].withSpaceBetween(width: 8),
      );
    } else if (type == MoneyTransactionType.outcome) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(transaction.amount.currency, style: textTheme),
          const Icon(Icons.arrow_downward, color: Colors.red),
        ].withSpaceBetween(width: 8),
      );
    }

    return Text(transaction.amount.currency);
  }
}
