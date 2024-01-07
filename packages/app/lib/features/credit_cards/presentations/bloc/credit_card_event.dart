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

class InviteMember extends CreditCardEvent {
  InviteMember(this.creditCardId, this.email);
  final String creditCardId;
  final String email;
}
