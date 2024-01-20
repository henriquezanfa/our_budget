import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:rxdart/rxdart.dart';

const _transactionsCollection = 'transactions';

class TransactionsDataSource {
  TransactionsDataSource({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore {
    _init();
  }

  void _init() {
    _firestore
        .collection(_transactionsCollection)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      final transactions = event.docs
          .map((doc) => MoneyTransaction.fromJson(doc.data()))
          .toList();

      _todoStreamController.add(transactions);
    });
  }

  final FirebaseFirestore _firestore;

  final _todoStreamController =
      BehaviorSubject<List<MoneyTransaction>>.seeded(const []);

  Stream<List<MoneyTransaction>> get getTransactions =>
      _todoStreamController.stream;

  Future<void> createTransaction(MoneyTransaction transaction) async {
    await _firestore
        .collection(_transactionsCollection)
        .doc(transaction.id)
        .set(transaction.toJson());
  }
}
