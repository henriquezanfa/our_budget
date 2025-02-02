import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/features/categories/data/dto/transaction_category_dto.dart';
import 'package:ob/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:ob/features/categories/presentation/modal/upsert_category_modal.dart';
import 'package:ob/ui/widgets/widgets.dart';

class AddNewCategoryButtonWidget extends StatelessWidget {
  const AddNewCategoryButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Add new category'),
      trailing: const Icon(Icons.add),
      onTap: () {
        showOBModalBottomSheet<TransactionCategoryDto>(
          context: context,
          child: const UpsertCategoryModal(),
          showDragHandle: false,
        ).then((value) {
          if (value != null) {
            context.read<CategoriesBloc>().add(
                  AddCategory(
                    category: value.description,
                    monthlyTarget: value.monthlyTarget,
                    isSaving: value.isSaving,
                    color: value.color,
                  ),
                );
          }
        });
      },
    );
  }
}
