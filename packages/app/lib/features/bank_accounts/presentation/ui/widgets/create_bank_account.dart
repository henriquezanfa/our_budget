import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/features/bank_accounts/data/dto/bank_account_creation_dto.dart';
import 'package:ob/features/bank_accounts/presentation/bloc/bank_account_bloc.dart';
import 'package:ob/features/bank_accounts/presentation/ui/modal/create_account_modal.dart';
import 'package:ob/ui/widgets/widgets.dart';

class CreateBankAccount extends StatelessWidget {
  factory CreateBankAccount.button() =>
      const CreateBankAccount._(isIcon: false);

  factory CreateBankAccount.icon() => const CreateBankAccount._(isIcon: true);
  const CreateBankAccount._({required bool isIcon}) : _isIcon = isIcon;

  final bool _isIcon;

  Future<void> _createBankAccount(BuildContext context) async {
    final bankAccountCreationDto =
        await showCreateAccountModal<BankAccountCreationDto>(
            context: context);

    if (bankAccountCreationDto != null) {
      if (!context.mounted) return;
      BlocProvider.of<BankAccountBloc>(context).add(
        AddBankAccount(bankAccountCreationDto),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isIcon) {
      return IconButton(
        onPressed: () => _createBankAccount(context),
        icon: const Icon(Icons.add_circle_outline),
      );
    }

    return OBElevatedButton(
      onPressed: () => _createBankAccount(context),
      text: 'Create bank account',
    );
  }
}
