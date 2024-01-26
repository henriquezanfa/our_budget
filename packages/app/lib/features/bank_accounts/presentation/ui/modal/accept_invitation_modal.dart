import 'package:flutter/material.dart';
import 'package:ob/domain/domain.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class AcceptInvitationModal extends StatelessWidget {
  const AcceptInvitationModal({
    required this.bankAccount,
    super.key,
  });
  final BankAccount bankAccount;

  @override
  Widget build(BuildContext context) {
    final owner = bankAccount.members.firstWhere(
      (member) => member.permission == PermissionsEnum.owner,
    );

    return OBModal(
      title: 'Invitation',
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have been invited to join ${bankAccount.name} by ${owner.email}',
              textAlign: TextAlign.center,
            ),
            OBElevatedButton(
              text: 'Accept',
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            Center(
              child: OBTextButton(
                text: 'Decline',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ].withSpaceBetween(height: 16),
        ),
      ),
    );
  }
}
