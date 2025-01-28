import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class CreateBankAccountsPage extends StatefulWidget {
  const CreateBankAccountsPage({super.key});

  @override
  State<CreateBankAccountsPage> createState() => _CreateBankAccountsPageState();
}

class _CreateBankAccountsPageState extends State<CreateBankAccountsPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _currencyController;
  AccountTypeEnum _accountType = AccountTypeEnum.current;
  late final TextEditingController _accountHolderNameController;

  late final FocusNode _nameFocusNode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _currencyController = TextEditingController();
    _accountHolderNameController = TextEditingController();

    _nameController.addListener(() {
      setState(() {});
    });

    _currencyController.addListener(() {
      setState(() {});
    });

    _accountHolderNameController.addListener(() {
      setState(() {});
    });

    _nameFocusNode = FocusNode();
  }

  bool get _isFormValid =>
      _nameController.text.isNotEmpty &&
      _currencyController.text.isNotEmpty &&
      _accountHolderNameController.text.isNotEmpty;

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
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _currencyController,
                    decoration: const InputDecoration(
                      labelText: 'Currency',
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<AccountTypeEnum>(
                    value: _accountType,
                    hint: const Text('Account type'),
                    onChanged: (value) {
                      setState(() {
                        _accountType = value ?? AccountTypeEnum.current;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: AccountTypeEnum.current,
                        child: Text('Current'),
                      ),
                      DropdownMenuItem(
                        value: AccountTypeEnum.savings,
                        child: Text('Savings'),
                      ),
                      DropdownMenuItem(
                        value: AccountTypeEnum.salary,
                        child: Text('Salary'),
                      ),
                      DropdownMenuItem(
                        value: AccountTypeEnum.other,
                        child: Text('Other'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _accountHolderNameController,
                    decoration: const InputDecoration(
                      labelText: 'Account holder name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isFormValid
                        ? () {
                            final bankAccount = BankAccount(
                              name: _nameController.text,
                              currency: _currencyController.text,
                              accountType: _accountType,
                              accountHolderName:
                                  _accountHolderNameController.text,
                            );
                            context
                                .read<OnboardingCubit>()
                                .addBankAccount(bankAccount);
                            context.push(
                              '${OBRoutes.onboarding}/${OBRoutes.createCategories}',
                            );
                          }
                        : null,
                    child: const Text('Add bank account'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
