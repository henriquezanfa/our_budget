import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/extensions/x_date_time.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';
import 'package:ob/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/theme/ob_sizes.dart';
import 'package:ob/ui/ui.dart';
import 'package:ob/ui/widgets/widgets.dart';

class UpsertTransactionWidget extends StatelessWidget {
  const UpsertTransactionWidget({
    this.transaction,
    super.key,
  });

  final MoneyTransaction? transaction;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionsBloc, TransactionsState>(
      listener: (context, state) {
        if (state is TransactionsError) {
          final theme = Theme.of(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: theme.colorScheme.error,
              behavior: SnackBarBehavior.floating,
              content: Text(state.error),
            ),
          );
        }
        if (state is TransactionCreated) {
          Navigator.of(context).pop();
        }
      },
      child: OBScreen.secondary(
        title: 'New Transaction',
        children: [
          SliverToBoxAdapter(child: _TransactionView(transaction: transaction)),
        ],
      ),
    );
  }
}

class _TransactionView extends StatefulWidget {
  const _TransactionView({
    this.transaction,
  });
  final MoneyTransaction? transaction;

  @override
  State<_TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<_TransactionView> {
  bool get _isEditing => widget.transaction != null;

  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;

  String? _selectedAccountId;
  TransactionCategory? _category;
  MoneyTransactionType? _type;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    final transaction = widget.transaction;

    _amountController =
        TextEditingController(text: transaction?.amount.toString());
    _descriptionController =
        TextEditingController(text: transaction?.description);

    _selectedAccountId = transaction?.accountId;
    _category = transaction?.category;
    _type = transaction?.type;
    _selectedDate = transaction?.date ?? DateTime.now();

    _amountController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const AmountInputText(),
          // OBTextField(
          //   controller: _amountController,
          //   autofocus: true,
          //   labelText: 'Amount',
          //   keyboardType: const TextInputType.numberWithOptions(
          //     decimal: true,
          //   ),
          //   inputTextFormatters: [
          //     FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
          //     TextInputFormatter.withFunction((oldValue, newValue) {
          //       final text = newValue.text;
          //       return text.isEmpty
          //           ? newValue
          //           : double.tryParse(text) == null
          //               ? oldValue
          //               : newValue;
          //     }),
          //   ],
          // ),
          DescriptionInputText(controller: _descriptionController),
          // OBTextField(
          //   controller: _descriptionController,
          //   labelText: 'Description',
          // ),
          // TODO: achar um jeito melhor de lidar com conta porque quando só
          //  tem uma, o widget adiciona a padding mesmo com Offstage
          // BlocBuilder<TransactionsBloc, TransactionsState>(
          //   buildWhen: (_, current) => current is AccountsAndCategoriesState,
          //   builder: (context, state) {
          //     if (state is AccountsAndCategoriesState) {
          //       accounts = state.accounts;
          //       if (accounts.isNotEmpty && _selectedAccountName == null) {
          //         _selectedAccountName = accounts.first.name;
          //         _selectedAccountId = accounts.first.id;
          //       }
          //     }

          //     if (accounts.length == 1) {
          //       return const Offstage();
          //     }

          //     return OBFieldSelection(
          //       labelText: 'Account',
          //       items: accounts.map((e) => e.name).toList(),
          //       initialSelectedItem: _selectedAccountName,
          //       onSelectionChanged: (selection) => setState(() {
          //         _selectedAccountId = accounts
          //             .firstWhereOrNull(
          //               (element) => element.name == selection,
          //             )
          //             ?.id;
          //         _selectedAccountName = selection;
          //       }),
          //     );
          //   },
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IncomeExpenseWidget(
                onChanged: (type) => setState(() => _type = type),
                type: _type,
              ),
              GestureDetector(
                onTap: () {
                  final date = _selectedDate ?? DateTime.now();
                  showAdaptiveDatePicker(
                    context: context,
                    firstDate: date,
                  ).then((value) {
                    if (value == null) return;
                    setState(() {
                      _selectedDate = value;
                    });
                  });
                },
                child: Row(
                  children: [
                    Text(_selectedDate?.yMd(context) ?? ''),
                    const SizedBox(width: OBSizes.small),
                    const Icon(Icons.calendar_month),
                  ],
                ),
              ),
            ],
          ),
          _CategorySelectorWidget(
            selectedCategory: _category,
            onChanged: (category) {
              setState(() {
                _category = category;
              });
            },
          ),
          OBElevatedButton(
            text: _isEditing ? 'Update' : 'Create',
            onPressed: () {
              _onTap(context);
            },
          ),
        ].withSpaceBetween(height: OBSizes.medium),
      ),
    );
  }

  void _onTap(BuildContext context) {
    if (_isEditing) {
      context.read<TransactionsBloc>().add(
            UpdateTransaction(
              id: widget.transaction!.id,
              account: _selectedAccountId,
              amount: double.tryParse(_amountController.text),
              category: _category,
              date: _selectedDate,
              description: _descriptionController.text,
              type: _type,
            ),
          );
      Navigator.of(context).maybePop();
    } else {
      context.read<TransactionsBloc>().add(
            CreateTransaction(
              account: _selectedAccountId,
              amount: double.tryParse(_amountController.text),
              category: _category,
              date: _selectedDate,
              description: _descriptionController.text,
              type: _type,
            ),
          );
    }
  }
}

class _CategorySelectorWidget extends StatelessWidget {
  const _CategorySelectorWidget({
    required this.selectedCategory,
    required this.onChanged,
  });

  final TransactionCategory? selectedCategory;
  final void Function(TransactionCategory?) onChanged;

  @override
  Widget build(BuildContext context) {
    var categories = <TransactionCategory>[];

    return BlocBuilder<TransactionsBloc, TransactionsState>(
      buildWhen: (_, current) => current is AccountsAndCategoriesState,
      builder: (context, state) {
        if (state is AccountsAndCategoriesState) {
          categories = state.categories;
        }

        return Wrap(
          spacing: OBSizes.xsmall,
          runSpacing: OBSizes.xsmall,
          children: categories.map(
            (e) {
              final isSelected = e.name == selectedCategory?.name;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(isSelected ? null : e),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(OBSizes.large),
                    color: isSelected
                        ? OBColors.tertiary
                        : OBColors.tertiary.withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: OBSizes.small,
                    vertical: OBSizes.xsmall,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        e.name,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: OBSizes.xxxSmall),
                        const Icon(
                          Icons.check,
                          size: OBSizes.medium,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}

class _IncomeExpenseWidget extends StatelessWidget {
  const _IncomeExpenseWidget({
    required this.type,
    required this.onChanged,
  });

  final MoneyTransactionType? type;
  final void Function(MoneyTransactionType) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(
          type == MoneyTransactionType.income
              ? MoneyTransactionType.outcome
              : MoneyTransactionType.income,
        );
      },
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: type == MoneyTransactionType.income
                ? const Icon(
                    Icons.arrow_upward,
                    key: ValueKey('income_icon'),
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.arrow_downward,
                    key: ValueKey('expense_icon'),
                    color: Colors.red,
                  ),
          ),
          const SizedBox(width: OBSizes.xsmall),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: type == MoneyTransactionType.income
                ? const Text('Income')
                : const Text('Expense'),
          ),
        ],
      ),
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
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: 40,
      fontFeatures: [const FontFeature.tabularFigures()],
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          // hack to center the icon vertically
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(r'$', style: textStyle),
        ),
        Flexible(
          child: IntrinsicWidth(
            child: TextFormField(
              controller: _controller,
              showCursor: false,
              style: textStyle,
              autofocus: true,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: '0',
                hintStyle: textStyle,
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
      ],
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
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(OBSizes.small),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    );

    const hintColor = Color.fromARGB(255, 193, 192, 192);

    return IntrinsicWidth(
      child: TextFormField(
        controller: widget.controller,
        textInputAction: TextInputAction.done,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          enabledBorder: border,
          constraints: const BoxConstraints(minWidth: 200),
          hintStyle: const TextStyle(color: hintColor),
          hintText: 'Description',
          floatingLabelAlignment: FloatingLabelAlignment.center,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(
              color: hintColor,
            ),
          ),
        ),
      ),
    );
  }
}
