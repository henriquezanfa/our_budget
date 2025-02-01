import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/features/bank_accounts/data/dto/bank_account_creation_dto.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/features/bank_accounts/presentation/bloc/bank_account_bloc.dart';
import 'package:ob/features/currencies_selection/domain/currency.dart';
import 'package:ob/features/currencies_selection/presentation/currency_selector_view.dart';
import 'package:ob/ui/widgets/widgets.dart';

// ignore: comment_references
/// Don't use this method directly, use [CreateBankAccount] instead.
Future<BankAccountCreationDto?> showCreateAccountModal<BankAccountCreationDto>({
  required BuildContext context,
}) {
  return showOBModalBottomSheet<BankAccountCreationDto>(
    context: context,
    child: BlocProvider.value(
      value: BlocProvider.of<BankAccountBloc>(context),
      child: const _CreateBankAccountModal(),
    ),
  );
}

class _CreateBankAccountModal extends StatefulWidget {
  const _CreateBankAccountModal();

  @override
  State<_CreateBankAccountModal> createState() =>
      _CreateBankAccountModalState();
}

class _CreateBankAccountModalState extends State<_CreateBankAccountModal> {
  final _nameController = TextEditingController();
  final _accountHolderNameController = TextEditingController();
  Currency? _selectedCurrency;

  AccountTypeEnum? _accountType;

  bool get _isFormValid =>
      _nameController.text.isNotEmpty &&
      _accountHolderNameController.text.isNotEmpty &&
      _selectedCurrency != null &&
      _accountType != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Create bank account'),
          const SizedBox(height: 16),
          Form(
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
                CurrencySelectorView(
                  initial: _selectedCurrency,
                  onChanged: (currency) {
                    setState(() {
                      _selectedCurrency = currency;
                    });
                  },
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
          ),
          const SizedBox(height: 16),
          BlocBuilder<BankAccountBloc, BankAccountState>(
            builder: (context, state) {
              return OBElevatedButton(
                isLoading: state is BankAccountLoading,
                onPressed: _isFormValid
                    ? () {
                        Navigator.of(context).pop(
                          BankAccountCreationDto(
                            name: _nameController.text,
                            currency: _selectedCurrency!.code.toLowerCase(),
                            accountType: _accountType!,
                            accountHolderName:
                                _accountHolderNameController.text,
                          ),
                        );
                      }
                    : null,
                text: 'Create',
              );
            },
          ),
        ],
      ),
    );
  }
}
