import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;

  String? selectedAccount;
  final List<String> accounts = [
    'ma',
    'kik',
  ];

  String? tag;
  final List<String> tags = [
    'Rent',
    'Groceries',
    'Restaurants',
  ];

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
    return OBScreen.secondary(
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
          child: OBFieldSelection(
            labelText: 'Category',
            items: tags,
            initialSelectedItem: tag,
            onSelectionChanged: (selection) => setState(() {
              tag = selection;
            }),
          ),
        ),
        SliverToBoxAdapter(
          child: OBFieldSelection(
            labelText: 'Account',
            items: accounts,
            initialSelectedItem: selectedAccount,
            onSelectionChanged: (selection) => setState(() {
              selectedAccount = selection;
            }),
          ),
        ),
        SliverToBoxAdapter(
          child: OBElevatedButton(
            text: 'Create',
            onPressed: () {},
          ),
        ),
      ].withSpaceBetween(height: 16, isSliver: true),
    );
  }
}
