import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ob/core/client/constants.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/features/bank_accounts/data/data_source/back_account_data_source.dart';
import 'package:ob/features/space/core.dart';
import 'package:ob/features/space/data/space_repository.dart';
import 'package:rxdart/rxdart.dart';

const _transactionsCollection = 'transactions';

class TransactionsDataSource {
  TransactionsDataSource({
    required FirebaseFirestore firestore,
    required BankAccountDataSource bankAccountDataSource,
    required SpaceRepository spaceRepository,
  })  : _firestore = firestore,
        _spaceRepository = spaceRepository,
        _bankAccountDataSource = bankAccountDataSource {
    _init();
  }

  Future<void> _init() async {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event == null) {
        _todoStreamController.add(const []);
        return;
      }

      final userId = event.uid;
      final bankAccountsIds = await _bankAccountDataSource.getBankAccounts(
        userId: userId,
        spaceId: _spaceRepository.currentSpaceId,
      );
      final bankAccountsIdsList = bankAccountsIds.map((e) => e.id).toList();

      _firestore
          .collection(OBCollections.space)
          .doc(_spaceRepository.currentSpaceId)
          .collection(_transactionsCollection)
          .where('accountId', whereIn: bankAccountsIdsList)
          .orderBy('date', descending: true)
          .snapshots()
          .listen((event) {
        final transactions = event.docs
            .map((doc) => MoneyTransaction.fromJson(doc.data()))
            .toList();

        _todoStreamController.add(transactions);
      });
    });
  }

  final FirebaseFirestore _firestore;
  final BankAccountDataSource _bankAccountDataSource;
  final SpaceRepository _spaceRepository;

  final _todoStreamController =
      BehaviorSubject<List<MoneyTransaction>>.seeded(const []);

  Stream<List<MoneyTransaction>> get getTransactions =>
      _todoStreamController.stream;

  Future<void> createTransaction({
    required SpaceId spaceId,
    required MoneyTransaction transaction,
  }) async {
    await _firestore
        .collection(OBCollections.space)
        .doc(spaceId)
        .collection(_transactionsCollection)
        .doc(transaction.id)
        .set(transaction.toJson());
  }

  Future<void> updateTransaction({
    required SpaceId spaceId,
    required MoneyTransaction transaction,
  }) async {
    await _firestore
        .collection(OBCollections.space)
        .doc(spaceId)
        .collection(_transactionsCollection)
        .doc(transaction.id)
        .update(transaction.toJson());
  }

  Future<void> deleteTransaction({
    required SpaceId spaceId,
    required String transactionId,
  }) async {
    await _firestore
        .collection(OBCollections.space)
        .doc(spaceId)
        .collection(_transactionsCollection)
        .doc(transactionId)
        .delete();
  }
}
