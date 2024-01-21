import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:ob/features/transactions/presentation/widgets/upsert_transaction_widget.dart';
import 'package:ob/ui/extensions/date_extensions.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/extensions/number_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    required this.transaction,
    super.key,
  });

  final MoneyTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      dismissThresholds: const {
        DismissDirection.endToStart: 0.8,
      },
      secondaryBackground: const ColoredBox(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      background: Container(),
      key: Key(transaction.id),
      onDismissed: (direction) {
        context.read<TransactionsBloc>().add(DeleteTransaction(transaction.id));
      },
      child: ListTile(
        onTap: () {
          showOBModalBottomSheet<void>(
            context: context,
            child: EditTransactionModal(transaction: transaction),
          );
        },
        title: Text(transaction.description ?? ''),
        trailing: TransactionValueWidget(transaction: transaction),
        subtitle: Text(transaction.date.ymdhms),
      ),
    );
  }
}

class EditTransactionModal extends StatelessWidget {
  const EditTransactionModal({
    required this.transaction,
    super.key,
  });
  final MoneyTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Transaction',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            UpsertTransactionWidget(transaction: transaction),
          ],
        ),
      ),
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
