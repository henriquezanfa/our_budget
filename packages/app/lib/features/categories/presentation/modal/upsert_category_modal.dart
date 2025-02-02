import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ob/app/view/show_toast.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';
import 'package:ob/features/categories/data/dto/transaction_category_dto.dart';
import 'package:ob/features/categories/presentation/widgets/category_item_widget.dart';
import 'package:ob/features/currencies_selection/presentation/currency_selector_view.dart';
import 'package:ob/ui/widgets/widgets.dart';

class UpsertCategoryModal extends StatefulWidget {
  const UpsertCategoryModal({
    this.category,
    super.key,
  });
  final TransactionCategory? category;

  @override
  State<UpsertCategoryModal> createState() => _UpsertCategoryModalState();
}

class _UpsertCategoryModalState extends State<UpsertCategoryModal> {
  final _categoryNameController = TextEditingController();
  final _monthlyTargetController = TextEditingController();
  late String _color = categoriesColors.keys.first;
  bool _isSaving = false;

  bool get _isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();

    final category = widget.category;
    if (category != null) {
      _categoryNameController.text = category.name;
      _monthlyTargetController.text = category.monthlyTarget != null
          ? category.monthlyTarget.toString()
          : '';
      _isSaving = category.isSaving;
      _color = category.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OBModal(
      title: _isEditing ? 'Edit category' : 'Create category',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Category name'),
                Flexible(
                  child: DescriptionInputText(
                    controller: _categoryNameController,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Monthly target'),
                Flexible(
                  child: AmountInputText(controller: _monthlyTargetController),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Category color'),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    alignment: Alignment.centerRight,
                    value: _color,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _color = value);
                      }
                    },
                    icon: const Visibility(
                      visible: false,
                      child: Icon(Icons.arrow_downward),
                    ),
                    // Map<String, Color> categoriesColors = {
                    items: categoriesColors.entries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.key,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  e.key.capitalize(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    color: e.value,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Is this category for saving?'),
                SizedBox(
                  height: 24,
                  child: Switch(
                    value: _isSaving,
                    onChanged: (value) {
                      setState(() {
                        _isSaving = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          OBElevatedButton(
            text: _isEditing ? 'Save' : 'Create',
            onPressed: () {
              if (_isEditing) {
                Navigator.of(context).pop(
                  widget.category!.copyWith(
                    name: _categoryNameController.text,
                    monthlyTarget:
                        double.tryParse(_monthlyTargetController.text),
                    isSaving: _isSaving,
                  ),
                );
              } else {
                final value = double.tryParse(_monthlyTargetController.text);
                if (value == null) {
                  showErrorToast(context, 'Please enter a valid number');
                  return;
                }
                Navigator.of(context).pop(
                  TransactionCategoryDto(
                    description: _categoryNameController.text,
                    icon: '',
                    monthlyTarget: value,
                    isSaving: _isSaving,
                    color: _color,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class DescriptionInputText extends StatefulWidget {
  const DescriptionInputText({required this.controller, super.key});

  final TextEditingController controller;

  @override
  State<DescriptionInputText> createState() => _DescriptionInputTextState();
}

class _DescriptionInputTextState extends State<DescriptionInputText> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: IntrinsicWidth(
            child: Container(
              constraints: const BoxConstraints(minWidth: 100),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 223, 223),
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: widget.controller,
                style: textStyle,
                autofocus: true,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: textStyle,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.only(top: 10),
                  isDense: true,
                  constraints: const BoxConstraints(
                    minWidth: 28,
                  ),
                  prefixIconConstraints: const BoxConstraints(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AmountInputText extends StatefulWidget {
  const AmountInputText({super.key, this.controller});

  final TextEditingController? controller;

  @override
  State<AmountInputText> createState() => AmountInputTextState();
}

class AmountInputTextState extends State<AmountInputText> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontFeatures: [const FontFeature.tabularFigures()],
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 223, 223),
        // border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: IntrinsicWidth(
              child: TextFormField(
                controller: _controller,
                style: textStyle,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: '0',
                  hintStyle: textStyle,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.only(top: 10),
                  isDense: true,
                  constraints: const BoxConstraints(
                    minWidth: 28,
                  ),
                  prefixIconConstraints: const BoxConstraints(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    final text = newValue.text;
                    return text.isEmpty
                        ? newValue
                        : double.tryParse(text) == null
                            ? oldValue
                            : newValue;
                  }),
                ],
              ),
            ),
          ),
          Padding(
            // hack to center the icon vertically
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(r'$', style: textStyle),
          ),
        ],
      ),
    );
  }
}
