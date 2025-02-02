import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/features/categories/data/dto/transaction_category_dto.dart';
import 'package:ob/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:ob/features/categories/presentation/modal/edit_category_modal.dart';
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
        _showDialog(context).then((value) {
          if (value != null) {
            context.read<CategoriesBloc>().add(
                  AddCategory(
                    category: value.description,
                    monthlyTarget: value.monthlyTarget,
                    isSaving: value.isSaving,
                  ),
                );
          }
        });
      },
    );
  }
}

Future<TransactionCategoryDto?> _showDialog(BuildContext context) async {
  return showOBModalBottomSheet<TransactionCategoryDto>(
    context: context,
    child: const EditCategoryModal(),
  );
}

class CreateCategoryModal extends StatefulWidget {
  const CreateCategoryModal({super.key});

  @override
  State<CreateCategoryModal> createState() => _CreateCategoryModalState();
}

class _CreateCategoryModalState extends State<CreateCategoryModal> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Create category'),
          const SizedBox(height: 16),
          OBTextField(
            labelText: 'Category name',
            keyboardType: TextInputType.emailAddress,
            focusNode: _focusNode,
            onChanged: (value) {
              setState(() {
                _textController.text = value;
              });
            },
          ),
          const SizedBox(height: 16),
          OBElevatedButton(
            text: 'Create',
            onPressed: () {
              Navigator.of(context).pop(_textController.text);
            },
          ),
        ],
      ),
    );
  }
}
