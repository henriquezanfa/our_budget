import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ob/core/client/constants.dart';
import 'package:ob/core/types/ob_types.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';

class BankAccountDataSource {
  BankAccountDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<BankAccount>> getBankAccounts(UserId userId) async {
    final query = _firestore
        .collection(OBCollections.bankAccount)
        .where(OBFields.userId, isEqualTo: userId);
    final data = await query.get();
    final bankAccounts = data.docs
        .map((doc) => BankAccount.fromJson(doc.data()))
        .toList(growable: false);

    return bankAccounts;
  }

  Future<void> addBankAccount(BankAccount bankAccount) async {
    final doc = _firestore
        .collection(OBCollections.bankAccount)
        .doc(bankAccount.id);
    await doc.set(bankAccount.toJson());
  }
}
