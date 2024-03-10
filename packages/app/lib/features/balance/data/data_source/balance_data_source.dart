import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ob/core/client/constants.dart';
import 'package:ob/domain/models/balance/balance.dart';
import 'package:ob/features/space/core.dart';

class BalanceDataSource {
  BalanceDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Stream<Balance> getBalance({
    required SpaceId spaceId,
    required String userId,
    required List<String> bankAccountsIds,
  }) {
    final transactionCollection = _firestore
        .collection(OBCollections.space)
        .doc(spaceId)
        .collection('transactions')
        .where('accountId', whereIn: bankAccountsIds)
        .orderBy('date', descending: true);

    return transactionCollection.snapshots().map((snapshot) {
      return snapshot.docs.fold(
        Balance.empty(),
        (balance, transaction) {
          final amount = transaction.data()['amount'] as double;
          final type = transaction.data()['type'] as String;

          if (type == 'income') {
            return balance.copyWith(
              balance: balance.balance + amount,
              incomes: balance.incomes + amount,
            );
          } else {
            return balance.copyWith(
              balance: balance.balance - amount,
              outcomes: balance.outcomes + amount,
            );
          }
        },
      );
    });
  }
}
