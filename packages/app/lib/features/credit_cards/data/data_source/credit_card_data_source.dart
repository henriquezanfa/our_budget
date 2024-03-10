import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ob/core/client/constants.dart';
import 'package:ob/core/types/ob_types.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';

class CreditCardDataSource {
  CreditCardDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<void> createCreditCard(CreditCard creditCard) async {
    final doc =
        _firestore.collection(OBCollections.creditCard).doc(creditCard.id);
    await doc.set(creditCard.toJson());
  }

  Future<List<CreditCard>> getCreditCards(UserId userId) async {
    final query = _firestore
        .collection(OBCollections.creditCard)
        .where('userId', isEqualTo: userId);

    final data = await query.get();

    final cards = await Future.wait(
      data.docs.map((doc) async {
        try {
          return CreditCard.fromJson(doc.data());
        } catch (e, s) {
          debugPrintStack(stackTrace: s, label: e.toString());
          rethrow;
        }
      }),
    );

    return cards;
  }
}
