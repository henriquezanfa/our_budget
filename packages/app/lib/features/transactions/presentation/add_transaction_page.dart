import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:ob/features/transactions/presentation/widgets/upsert_transaction_widget.dart';
import 'package:ob/ui/widgets/widgets.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsBloc(
        inject.get(),
        inject.get(),
        inject.get(),
      )..add(GetAccountsAndCategoriesEvent()),
      child: OBScreen.secondary(
        title: 'New Transaction',
        children: const [SliverToBoxAdapter(child: UpsertTransactionWidget())],
      ),
    );
  }
}
