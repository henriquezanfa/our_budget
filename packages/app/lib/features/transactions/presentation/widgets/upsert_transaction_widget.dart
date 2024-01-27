import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';
import 'package:ob/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class UpsertTransactionWidget extends StatelessWidget {
  const UpsertTransactionWidget({
    this.transaction,
    super.key,
  });

  final MoneyTransaction? transaction;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsBloc(
        inject.get(),
        inject.get(),
        inject.get(),
      )..add(GetAccountsAndCategoriesEvent()),
      child: _TransactionView(transaction: transaction),
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
  String? _selectedAccountName;
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
    var categories = <TransactionCategory>[];
    var accounts = <BankAccount>[];

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
      child: Column(
        children: [
          OBTextField(
            controller: _amountController,
            labelText: 'Amount',
            keyboardType: TextInputType.number,
          ),
          OBTextField(
            controller: _descriptionController,
            labelText: 'Description',
          ),
          OBDatePicker(
            selectedDate: _selectedDate,
            onDateSelected: (date) => setState(() => _selectedDate = date),
          ),
          OBFieldSelection(
            labelText: 'Type',
            items: MoneyTransactionType.values.map((e) => e.name).toList(),
            initialSelectedItem: _type?.value,
            onSelectionChanged: (selection) => setState(() {
              _type = MoneyTransactionType.values.firstWhereOrNull(
                (element) => element.name == selection,
              );
            }),
          ),
          BlocBuilder<TransactionsBloc, TransactionsState>(
            buildWhen: (_, current) => current is AccountsAndCategoriesState,
            builder: (context, state) {
              if (state is AccountsAndCategoriesState) {
                categories = state.categories;
              }

              return OBFieldSelection(
                labelText: 'Category',
                items: categories.map((e) => e.name).toList(),
                initialSelectedItem: _category?.name,
                onSelectionChanged: (selection) => setState(() {
                  _category = categories.firstWhereOrNull(
                    (element) => element.name == selection,
                  );
                }),
              );
            },
          ),
          BlocBuilder<TransactionsBloc, TransactionsState>(
            buildWhen: (_, current) => current is AccountsAndCategoriesState,
            builder: (context, state) {
              if (state is AccountsAndCategoriesState) {
                accounts = state.accounts;
              }

              return OBFieldSelection(
                labelText: 'Account',
                items: accounts.map((e) => e.name).toList(),
                initialSelectedItem: _selectedAccountName,
                onSelectionChanged: (selection) => setState(() {
                  _selectedAccountId = accounts
                      .firstWhereOrNull(
                        (element) => element.name == selection,
                      )
                      ?.id;
                  _selectedAccountName = selection;
                }),
              );
            },
          ),
          OBElevatedButton(
            text: _isEditing ? 'Update' : 'Create',
            onPressed: () => _onTap(context),
          ),
        ].withSpaceBetween(height: 16),
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
