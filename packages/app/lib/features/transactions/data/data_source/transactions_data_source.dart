import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';

const _transactionsCollection = 'transactions';

class TransactionsDataSource {
  TransactionsDataSource({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<void> createTransaction(MoneyTransaction transaction) async {
    await _firestore
        .collection(_transactionsCollection)
        .doc(transaction.id)
        .set(transaction.toJson());
  }
}
