import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/features/credit_cards/data/dto/credit_card_creation_dto.dart';
import 'package:ob/features/credit_cards/data/repository/credit_card_repository.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';

part 'credit_card_event.dart';
part 'credit_card_state.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  CreditCardBloc(this._creditCardRepository) : super(CreditCardInitial()) {
    on<GetCreditCards>(_getCreditCards);
    on<CreateCreditCardEvent>(_createCreditCard);
  }
  final CreditCardRepository _creditCardRepository;

  FutureOr<void> _getCreditCards(
    GetCreditCards event,
    Emitter<CreditCardState> emit,
  ) async {
    emit(CreditCardLoading());
    await _creditCardRepository.getCreditCards().then((result) {
      result.fold(
        (error) => emit(CreditCardError(error)),
        (creditCards) {
          if (creditCards.isEmpty) {
            emit(NoCreditCard());
          } else {
            emit(CreditCardLoaded(creditCards));
          }
        },
      );
    });
  }

  FutureOr<void> _createCreditCard(
    CreateCreditCardEvent event,
    Emitter<CreditCardState> emit,
  ) async {
    emit(CreditCardLoading());
    await _creditCardRepository.addCreditCard(event.creditCardCreationDto).then(
      (result) {
        result.fold(
          (error) => emit(CreditCardError(error)),
          (_) => emit(CreditCardAdded()),
        );
      },
    );
  }
}
