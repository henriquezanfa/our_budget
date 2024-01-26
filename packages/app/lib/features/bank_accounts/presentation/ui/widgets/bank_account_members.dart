import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/domain/models/member/member.dart';
import 'package:ob/features/bank_accounts/presentation/bloc/bank_account_bloc.dart';
import 'package:ob/ui/widgets/widgets.dart';

class BankAccountMembersWidget extends StatelessWidget {
  const BankAccountMembersWidget({
    required this.bankAccountId,
    this.invitedMembersEmails,
    this.accountMembers,
    super.key,
  });
  final List<Member>? accountMembers;
  final List<String>? invitedMembersEmails;
  final String bankAccountId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
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
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: invitedMembersEmails?.length ?? 0,
          itemBuilder: (context, index) {
            final invitedMemberEmail = invitedMembersEmails![index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(invitedMemberEmail),
              subtitle: Text(invitedMemberEmail),
              trailing: Text(
                'Invited',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          },
        ),
        OBElevatedButton(
          text: 'Invite member',
          onPressed: () {
            showOBModalBottomSheet<String>(
              context: context,
              child: const InviteMemberModal(),
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
    return OBModal(
      title: 'Invite member',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
