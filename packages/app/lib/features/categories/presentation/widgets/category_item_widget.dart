import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/extensions/x_double.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';
import 'package:ob/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:ob/features/categories/presentation/modal/upsert_category_modal.dart';
import 'package:ob/ui/widgets/widgets.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    required this.category,
    super.key,
  });
  final TransactionCategory category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: SizedBox(
        height: 12,
        width: 12,
        child: CircleAvatar(
          backgroundColor:
              categoriesColors[category.color] ?? theme.colorScheme.primary,
        ),
      ),
      minLeadingWidth: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(category.name),
      subtitle:
          category.isSaving ? const Text('Savings') : const Text('Spending'),
      trailing: Text(category.monthlyTarget!.toCurrency()),
      leadingAndTrailingTextStyle: TextStyle(
        color: theme.colorScheme.onSurface,
      ),
      onTap: () {
        showOBModalBottomSheet<TransactionCategory>(
          context: context,
          showDragHandle: false,
          child: UpsertCategoryModal(category: category),
        ).then((value) {
          if (value != null) {
            context.read<CategoriesBloc>().add(
                  UpdateCategory(value),
                );
          }
        });
      },
    );
  }
}

Map<String, Color> categoriesColors = {
  'black': Colors.black,
  'blue': Colors.blue,
  'green': Colors.green,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'red': Colors.red,
  'yellow': Colors.yellow,
  'white': Colors.white,
  'grey': Colors.grey,
  'pink': Colors.pink,
  'cyan': Colors.cyan,
  'teal': Colors.teal,
  'amber': Colors.amber,
  'lime': Colors.lime,
};
