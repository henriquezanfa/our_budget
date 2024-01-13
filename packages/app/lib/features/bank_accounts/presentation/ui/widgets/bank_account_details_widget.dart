import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/domain/domain.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';
import 'package:ob/features/bank_accounts/presentation/bloc/bank_account_bloc.dart';
import 'package:ob/ui/widgets/widgets.dart';

class BankAccountDetailsWidget extends StatelessWidget {
  const BankAccountDetailsWidget({
    required this.bankAccount,
    super.key,
  });
  final BankAccount bankAccount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BankAccountBloc(inject()),
      child: BankAccountDetailsView(
        bankAccount: bankAccount,
      ),
    );
  }
}

class BankAccountDetailsView extends StatefulWidget {
  const BankAccountDetailsView({
    required this.bankAccount,
    super.key,
  });

  final BankAccount bankAccount;

  @override
  State<BankAccountDetailsView> createState() =>
      _BankAccountDetailsWidgetState();
}

class _BankAccountDetailsWidgetState extends State<BankAccountDetailsView> {
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
    return BlocListener<BankAccountBloc, BankAccountState>(
      listener: (context, state) {
        if (state is BankAccountMemberInvited) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Member invited'),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          ),
          const SizedBox(height: 16),
          AccountMembersList(
            accountMembers: widget.bankAccount.members,
            bankAccountId: widget.bankAccount.id,
          ),
        ],
      ),
    );
  }
}

class AccountMembersList extends StatelessWidget {
  const AccountMembersList({
    required this.bankAccountId,
    this.accountMembers,
    super.key,
  });
  final List<Member>? accountMembers;
  final String bankAccountId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Account members'),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: accountMembers?.length ?? 0,
          itemBuilder: (context, index) {
            final accountMember = accountMembers![index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(accountMember.email),
              subtitle: Text(accountMember.email),
            );
          },
        ),
        OBElevatedButton(
          text: 'Invite member',
          onPressed: () {
            showModalBottomSheet<String>(
              context: context,
              builder: (context) => const InviteMemberModal(),
            ).then((value) {
              if (value != null) {
                context.read<BankAccountBloc>().add(
                      InviteMember(
                        bankAccountId,
                        value,
                      ),
                    );
              }
            });
          },
        ),
      ],
    );
  }
}

class InviteMemberModal extends StatefulWidget {
  const InviteMemberModal({super.key});

  @override
  State<InviteMemberModal> createState() => _InviteMemberModalState();
}

class _InviteMemberModalState extends State<InviteMemberModal> {
  final _emailController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Invite member'),
          const SizedBox(height: 16),
          OBTextField(
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            focusNode: _focusNode,
            onChanged: (value) {
              setState(() {
                _emailController.text = value;
              });
            },
          ),
          const SizedBox(height: 16),
          OBElevatedButton(
            text: 'Invite',
            onPressed: () {
              Navigator.of(context).pop(_emailController.text);
            },
          ),
        ],
      ),
    );
  }
}
