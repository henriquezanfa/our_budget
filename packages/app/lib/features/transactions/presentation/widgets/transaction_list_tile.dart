import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:ob/ui/extensions/date_extensions.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/extensions/number_extensions.dart';

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
          context.push(OBRoutes.addTransaction, extra: transaction);
        },
        title: Text(transaction.description ?? ''),
        trailing: TransactionValueWidget(transaction: transaction),
        subtitle: Text(transaction.date.ymdhms),
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
