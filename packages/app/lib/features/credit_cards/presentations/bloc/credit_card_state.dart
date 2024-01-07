part of 'credit_card_bloc.dart';

@immutable
sealed class CreditCardState {}

final class CreditCardInitial extends CreditCardState {}

final class CreditCardLoading extends CreditCardState {}

final class CreditCardLoaded extends CreditCardState {
  CreditCardLoaded(this.creditCards);
  final List<CreditCard> creditCards;
}

final class NoCreditCard extends CreditCardState {}

final class CreditCardError extends CreditCardState {
  CreditCardError(this.error);
  final OBError error;
}

final class CreditCardAdded extends CreditCardState {}

final class CreditCardMemberInvited extends CreditCardState {}
