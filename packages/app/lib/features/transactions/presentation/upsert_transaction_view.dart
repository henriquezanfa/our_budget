import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:ob/features/transactions/presentation/widgets/upsert_transaction_widget.dart';

class UpsertTransactionView extends StatelessWidget {
  const UpsertTransactionView({super.key, this.transaction});

  final MoneyTransaction? transaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsBloc(
        inject.get(),
        inject.get(),
        inject.get(),
      )..add(GetAccountsAndCategoriesEvent()),
      child: UpsertTransactionWidget(transaction: transaction),
    );
  }
}
