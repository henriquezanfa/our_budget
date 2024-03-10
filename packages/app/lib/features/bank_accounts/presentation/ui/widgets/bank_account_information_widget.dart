import 'package:flutter/material.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';

class BankAccountInformationWidget extends StatefulWidget {
  const BankAccountInformationWidget({
    required this.bankAccount,
    super.key,
  });
  final BankAccount bankAccount;

  @override
  State<BankAccountInformationWidget> createState() =>
      _BankAccountInformationWidgetState();
}

class _BankAccountInformationWidgetState
    extends State<BankAccountInformationWidget> {
  final _nameController = TextEditingController();
  final _currencyController = TextEditingController();
  final _accountHolderNameController = TextEditingController();

  AccountTypeEnum? _accountType;

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.bankAccount.name;
    _currencyController.text = widget.bankAccount.currency;
    _accountHolderNameController.text = widget.bankAccount.accountHolderName;
    _accountType = widget.bankAccount.accountType;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Bank name',
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _accountHolderNameController,
            decoration: const InputDecoration(
              hintText: 'Holder name',
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _currencyController,
            decoration: const InputDecoration(
              hintText: 'Currency',
            ),
          ),
          const SizedBox(height: 8),
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
        ],
      ),
    );
  }
}
