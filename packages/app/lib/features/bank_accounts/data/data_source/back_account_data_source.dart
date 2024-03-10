import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ob/core/client/constants.dart';
import 'package:ob/core/types/ob_types.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';

class BankAccountDataSource {
  BankAccountDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<BankAccount>> getBankAccounts(UserId userId) async {
    final query = _firestore.collection(OBCollections.bankAccount);

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
}
