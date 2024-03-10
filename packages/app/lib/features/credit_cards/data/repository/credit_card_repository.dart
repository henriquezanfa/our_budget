import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/features/credit_cards/data/data_source/credit_card_data_source.dart';
import 'package:ob/features/credit_cards/data/dto/credit_card_creation_dto.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';
import 'package:uuid/uuid.dart';

class CreditCardRepository {
  CreditCardRepository({required CreditCardDataSource creditCardDataSource})
      : _creditCardDataSource = creditCardDataSource;

  final CreditCardDataSource _creditCardDataSource;

  Future<Either<OBError, List<CreditCard>>> getCreditCards() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final creditCards = await _creditCardDataSource.getCreditCards(userId);
      return right(creditCards);
    } catch (e) {
      debugPrint(e.toString());
      return left(
        OBError(
          userMessage: ErrorMessages.somethingWentWrong,
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<OBError, void>> addCreditCard(
    CreditCardCreationDto accountCreationDto,
  ) async {
    try {
      const uuid = Uuid();
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final id = uuid.v4();

      final creditCard = accountCreationDto.toCreditCard(userId, id);

      await _creditCardDataSource.createCreditCard(creditCard);
      return right(null);
    } catch (e) {
      return left(
        OBError(
          userMessage: ErrorMessages.somethingWentWrong,
          message: e.toString(),
        ),
      );
    }
  }
}
