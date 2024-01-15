import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';
import 'package:ob/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:ob/features/categories/presentation/modal/edit_category_modal.dart';
import 'package:ob/ui/widgets/widgets.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    required this.category,
    super.key,
  });
  final TransactionCategory category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      onTap: () {
        showOBModalBottomSheet<TransactionCategory>(
          context: context,
          child: EditCategoryModal(category: category),
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
