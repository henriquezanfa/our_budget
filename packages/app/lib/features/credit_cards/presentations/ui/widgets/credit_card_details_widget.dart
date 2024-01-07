import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/domain/domain.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';
import 'package:ob/features/credit_cards/presentations/bloc/credit_card_bloc.dart';
import 'package:ob/features/login/presentation/login.dart';
import 'package:ob/ui/widgets/widgets.dart';

class CreditCardDetailsWidget extends StatelessWidget {
  const CreditCardDetailsWidget({
    required this.creditCard,
    super.key,
  });
  final CreditCard creditCard;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreditCardBloc(inject()),
      child: CreditCardDetailsView(
        creditCard: creditCard,
      ),
    );
  }
}

class CreditCardDetailsView extends StatefulWidget {
  const CreditCardDetailsView({
    required this.creditCard,
    super.key,
  });

  final CreditCard creditCard;

  @override
  State<CreditCardDetailsView> createState() => _CreditCardDetailsWidgetState();
}

class _CreditCardDetailsWidgetState extends State<CreditCardDetailsView> {
  final _currencyController = TextEditingController();
  final _accountHolderNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _currencyController.text = widget.creditCard.currency;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreditCardBloc, CreditCardState>(
      listener: (context, state) {
        if (state is CreditCardMemberInvited) {
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
              ],
            ),
          ),
          const SizedBox(height: 16),
          AccountMembersList(
            accountMembers: widget.creditCard.members,
            bankAccountId: widget.creditCard.id,
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
                context.read<CreditCardBloc>().add(
                      InviteMember(bankAccountId, value),
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
