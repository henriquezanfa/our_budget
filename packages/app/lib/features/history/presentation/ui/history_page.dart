import 'package:flutter/material.dart';
import 'package:ob/features/transactions/presentation/transactions_list.dart';
import 'package:ob/ui/widgets/widgets.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OBScreen.primary(
      title: 'History',
      slivers: const [
        SliverToBoxAdapter(
          child: TransactionsList(),
        ),
      ],
    );
  }
}
