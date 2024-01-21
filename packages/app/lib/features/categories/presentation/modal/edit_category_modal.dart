import 'package:flutter/material.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';
import 'package:ob/ui/widgets/widgets.dart';

class EditCategoryModal extends StatefulWidget {
  const EditCategoryModal({
    required this.category,
    super.key,
  });
  final TransactionCategory category;

  @override
  State<EditCategoryModal> createState() => _EditCategoryModalState();
}

class _EditCategoryModalState extends State<EditCategoryModal> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textController.text = widget.category.name;
  }

  @override
  Widget build(BuildContext context) {
    return OBModal(
      title: 'Edit category',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OBTextField(
            labelText: 'Category name',
            controller: _textController,
          ),
          const SizedBox(height: 16),
          OBElevatedButton(
            text: 'Save',
            onPressed: () {
              Navigator.of(context).pop(
                widget.category.copyWith(
                  name: _textController.text,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
