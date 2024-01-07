import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ob/core/client/constants.dart';
import 'package:ob/core/types/ob_types.dart';
import 'package:ob/domain/domain.dart';
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

    final accountsWithMembers = await Future.wait(
      data.docs.map((doc) async {
        try {
          final members = await getCreditCardMembers(doc.id);
          return CreditCard.fromJson(doc.data()).copyWith(members: members);
        } catch (e, s) {
          debugPrintStack(stackTrace: s, label: e.toString());
          rethrow;
        }
      }),
    );

    return accountsWithMembers;
  }

  Future<List<Member>> getCreditCardMembers(
    String creditCardId,
  ) async {
    final query = _firestore
        .collection(OBCollections.creditCard)
        .doc(creditCardId)
        .collection(OBCollections.members);
    final data = await query.get();
    final members = data.docs
        .map((doc) => Member.fromJson(doc.data()))
        .toList(growable: false);

    return members;
  }

  Future<void> inviteMember(
    String creditCardId,
    Member accountMember,
  ) async {
    final doc = _firestore
        .collection(OBCollections.creditCard)
        .doc(creditCardId)
        .collection(OBCollections.members)
        .doc();
    await doc.set(accountMember.toJson());
  }

  Future<void> addMember(
    String creditCardId,
    Member accountMember,
  ) async {
    final doc = _firestore
        .collection(OBCollections.creditCard)
        .doc(creditCardId)
        .collection(OBCollections.members)
        .doc();
    await doc.set(accountMember.toJson());
  }
}
