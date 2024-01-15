import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ob/features/transactions/presentation/transactions_list.dart';
import 'package:ob/ui/widgets/widgets.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OBScreen.primary(
      title: 'History',
      actions: [
        IconButton(
          onPressed: () {
            showModalBottomSheet<void>(
              useRootNavigator: true,
              isScrollControlled: true,
              showDragHandle: true,
              useSafeArea: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              context: context,
              builder: (context) => const AddExerciseModal(),
            );
          },
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
      slivers: const [
        SliverToBoxAdapter(
          child: Text('Transactions'),
        ),
        SliverToBoxAdapter(
          child: TransactionsList(),
        ),
      ],
    );
  }
}

class AddExerciseModal extends StatelessWidget {
  const AddExerciseModal({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Exercise',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Exercise Name',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Sets',
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
