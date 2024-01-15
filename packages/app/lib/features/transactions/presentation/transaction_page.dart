import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

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
  String? _category;
  DateTime? _selectedDate;

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
    var categories = <String>[];
    var accounts = <String>[];

    return BlocListener<TransactionsBloc, TransactionsState>(
      listenWhen: (previous, current) => current is TransactionsError,
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
      },
      child: OBScreen.secondary(
        title: 'Transactions',
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
            child: BlocBuilder<TransactionsBloc, TransactionsState>(
              buildWhen: (_, current) => current is AccountsAndCategoriesState,
              builder: (context, state) {
                if (state is AccountsAndCategoriesState) {
                  categories = state.categories;
                }

                return OBFieldSelection(
                  labelText: 'Category',
                  items: categories,
                  initialSelectedItem: _category,
                  onSelectionChanged: (selection) => setState(() {
                    _category = selection;
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
