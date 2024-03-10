import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/features/credit_cards/data/data_source/credit_card_data_source.dart';
import 'package:ob/features/credit_cards/data/dto/credit_card_creation_dto.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';
import 'package:ob/features/space/data/space_repository.dart';
import 'package:uuid/uuid.dart';

class CreditCardRepository {
  CreditCardRepository({
    required CreditCardDataSource creditCardDataSource,
    required SpaceRepository spaceRepository,
  })  : _creditCardDataSource = creditCardDataSource,
        _spaceRepository = spaceRepository;

  final CreditCardDataSource _creditCardDataSource;
  final SpaceRepository _spaceRepository;

  Future<Either<OBError, List<CreditCard>>> getCreditCards() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final spaceId = _spaceRepository.getCurrentSpaceId();
      final creditCards = await _creditCardDataSource.getCreditCards(
        spaceId: spaceId,
        userId: userId,
      );
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
      final spaceId = _spaceRepository.getCurrentSpaceId();

      await _creditCardDataSource.createCreditCard(
        creditCard: creditCard,
        spaceId: spaceId,
      );
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
