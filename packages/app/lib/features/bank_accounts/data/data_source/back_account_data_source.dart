import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ob/core/client/constants.dart';
import 'package:ob/core/types/ob_types.dart';
import 'package:ob/domain/domain.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';

class BankAccountDataSource {
  BankAccountDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<BankAccount>> getBankAccounts(UserId userId) async {
    final query = _firestore
        .collection(OBCollections.bankAccount)
        .where('membersIds', arrayContainsAny: [userId]);

    final data = await query.get();

    return data.docs.map((doc) {
      final data = doc.data();
      final account = BankAccount.fromJson(data);
      return account;
    }).toList();
  }

  Future<void> createBankAccount(BankAccount bankAccount) async {
    final doc =
        _firestore.collection(OBCollections.bankAccount).doc(bankAccount.id);
    await doc.set(bankAccount.toJson());
  }

  Future<void> inviteMember(
    String bankAccountId,
    Member accountMember,
  ) async {
    final doc =
        _firestore.collection(OBCollections.bankAccount).doc(bankAccountId);

    await doc.update({
      'invitedMembersEmails': FieldValue.arrayUnion([accountMember.email]),
    });
  }

  Future<List<Member>> getBankAccountMembers(
    String bankAccountId,
  ) async {
    final query = _firestore
        .collection(OBCollections.bankAccount)
        .doc(bankAccountId)
        .collection(OBCollections.members);
    final data = await query.get();
    final members = data.docs
        .map((doc) => Member.fromJson(doc.data()))
        .toList(growable: false);

    return members;
  }

  Future<List<BankAccount>> getInvitedBankAccounts(String userEmail) async {
    final query = _firestore
        .collection(OBCollections.bankAccount)
        .where('invitedMembersEmails', arrayContainsAny: [userEmail]);

    final data = await query.get();

    return data.docs.map((doc) {
      final data = doc.data();
      final account = BankAccount.fromJson(data);
      return account;
    }).toList();
  }

  Future<void> acceptInvitation(
    String bankAccountId,
    String userId,
    String userEmail,
  ) async {
    final doc =
        _firestore.collection(OBCollections.bankAccount).doc(bankAccountId);

    await doc.update({
      'membersIds': FieldValue.arrayUnion([userId]),
      'members': FieldValue.arrayUnion([
        {
          'userId': userId,
          'email': userEmail,
          'permission': PermissionsEnum.readWrite.name,
          'status': InviteStatusEnum.accepted.name,
        }
      ]),
      'invitedMembersEmails': FieldValue.arrayRemove([userEmail]),
    });
  }
}
