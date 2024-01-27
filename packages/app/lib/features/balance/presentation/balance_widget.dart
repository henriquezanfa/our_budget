import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/domain/models/balance/balance.dart';
import 'package:ob/features/balance/presentation/bloc/balance_bloc.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/extensions/number_extensions.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BalanceBloc(inject(), inject())..add(GetBalance()),
      child: const _BalanceView(),
    );
  }
}

class _BalanceView extends StatelessWidget {
  const _BalanceView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceBloc, BalanceState>(
      builder: (context, state) {
        if (state is BalanceInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BalanceLoaded) {
          return _BalanceWidget(balance: state.balance);
        } else if (state is BalanceError) {
          return Text(state.message);
        } else {
          return const Center(
            child: Text('Unknown state'),
          );
        }
      },
    );
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({
    required this.balance,
  });

  final Balance balance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            balance.balance.currency,
            style: theme.textTheme.headlineLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                  ),
                  Text(
                    'Income: ${balance.incomes.currency}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ].withSpaceBetween(width: 8),
              ),
              Row(
                children: [
                  const Icon(Icons.arrow_downward, color: Colors.red),
                  Text(
                    'Expense: ${balance.outcomes.currency}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ].withSpaceBetween(width: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
