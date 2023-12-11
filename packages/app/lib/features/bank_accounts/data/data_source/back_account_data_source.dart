import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ob/core/client/constants.dart';
import 'package:ob/core/types/ob_types.dart';
import 'package:ob/features/bank_accounts/domain/model/account_member.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';

class BankAccountDataSource {
  BankAccountDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<BankAccount>> getBankAccounts(UserId userId) async {
    final query = _firestore
        .collection(OBCollections.bankAccount)
        .where('userId', isEqualTo: userId);

    final data = await query.get();

    final accountsWithMembers = await Future.wait(
      data.docs.map((doc) async {
        try {
          final members = await getBankAccountMembers(doc.id);
          return BankAccount.fromJson(doc.data()).copyWith(members: members);
        } catch (e, s) {
          debugPrintStack(stackTrace: s, label: e.toString());
          rethrow;
        }
      }),
    );

    return accountsWithMembers;
  }

  Future<void> addBankAccount(BankAccount bankAccount) async {
    final doc =
        _firestore.collection(OBCollections.bankAccount).doc(bankAccount.id);
    await doc.set(bankAccount.toJson());
  }

  Future<void> addBankAccountMember(
    String bankAccountId,
    AccountMember accountMember,
  ) async {
    final doc = _firestore
        .collection(OBCollections.bankAccount)
        .doc(bankAccountId)
        .collection(OBCollections.members)
        .doc();
    await doc.set(accountMember.toJson());
  }

  Future<void> inviteMember(
    String bankAccountId,
    AccountMember accountMember,
  ) async {
    final doc = _firestore
        .collection(OBCollections.bankAccount)
        .doc(bankAccountId)
        .collection(OBCollections.members)
        .doc();
    await doc.set(accountMember.toJson());
  }

  Future<List<AccountMember>> getBankAccountMembers(
    String bankAccountId,
  ) async {
    final query = _firestore
        .collection(OBCollections.bankAccount)
        .doc(bankAccountId)
        .collection(OBCollections.members);
    final data = await query.get();
    final members = data.docs
        .map((doc) => AccountMember.fromJson(doc.data()))
        .toList(growable: false);

    return members;
  }
}
