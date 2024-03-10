part of 'credit_card_bloc.dart';

@immutable
sealed class CreditCardEvent {}

class GetCreditCards extends CreditCardEvent {
  GetCreditCards();
}

class CreateCreditCardEvent extends CreditCardEvent {
  CreateCreditCardEvent(this.creditCardCreationDto);
  final CreditCardCreationDto creditCardCreationDto;
}
