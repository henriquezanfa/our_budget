import 'package:flutter/material.dart';

class CreateBankAccountsPage extends StatefulWidget {
  const CreateBankAccountsPage({super.key});

  @override
  State<CreateBankAccountsPage> createState() => _CreateBankAccountsPageState();
}

class _CreateBankAccountsPageState extends State<CreateBankAccountsPage> {
  //   required this.name,
  // required this.currency,
  // required this.accountType,
  // required this.accountHolderName,

  late final TextEditingController _nameController;
  late final TextEditingController _currencyController;
  late final TextEditingController _accountTypeController;
  late final TextEditingController _accountHolderNameController;

  late final FocusNode _nameFocusNode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Step 2 - Add your first bank account',
                  style: theme.textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Add your bank accounts to keep track of your transactions and balances.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
