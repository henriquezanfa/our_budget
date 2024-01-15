import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';
import 'package:ob/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsBloc(
        inject.get(),
        inject.get(),
        inject.get(),
      )..add(GetAccountsAndCategoriesEvent()),
      child: const _TransactionView(),
    );
  }
}

class _TransactionView extends StatefulWidget {
  const _TransactionView();

  @override
  State<_TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<_TransactionView> {
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;

  String? _selectedAccount;
  TransactionCategory? _category;
  MoneyTransactionType? _type;
  DateTime? _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _amountController = TextEditingController();
    _descriptionController = TextEditingController();

    _amountController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var categories = <TransactionCategory>[];
    var accounts = <String>[];

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
        slivers: [
          SliverToBoxAdapter(
            child: OBTextField(
              controller: _amountController,
              labelText: 'Amount',
              keyboardType: TextInputType.number,
            ),
          ),
          SliverToBoxAdapter(
            child: OBTextField(
              controller: _descriptionController,
              labelText: 'Description',
            ),
          ),
          SliverToBoxAdapter(
            child: OBDatePicker(
              selectedDate: _selectedDate,
              onDateSelected: (date) => setState(() => _selectedDate = date),
            ),
          ),
          SliverToBoxAdapter(
            child: OBFieldSelection(
              labelText: 'Type',
              items: MoneyTransactionType.values.map((e) => e.name).toList(),
              initialSelectedItem: _type?.value,
              onSelectionChanged: (selection) => setState(() {
                _type = MoneyTransactionType.values.firstWhereOrNull(
                  (element) => element.name == selection,
                );
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<TransactionsBloc, TransactionsState>(
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
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<TransactionsBloc, TransactionsState>(
              buildWhen: (_, current) => current is AccountsAndCategoriesState,
              builder: (context, state) {
                if (state is AccountsAndCategoriesState) {
                  accounts = state.accounts;
                }

                return OBFieldSelection(
                  labelText: 'Account',
                  items: accounts,
                  initialSelectedItem: _selectedAccount,
                  onSelectionChanged: (selection) => setState(() {
                    _selectedAccount = selection;
                  }),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: OBElevatedButton(
              text: 'Create',
              onPressed: () {
                context.read<TransactionsBloc>().add(
                      CreateTransaction(
                        account: _selectedAccount,
                        amount: double.tryParse(_amountController.text),
                        category: _category,
                        date: _selectedDate,
                        description: _descriptionController.text,
                        type: _type,
                      ),
                    );
              },
            ),
          ),
        ].withSpaceBetween(height: 16, isSliver: true),
      ),
    );
  }
}
