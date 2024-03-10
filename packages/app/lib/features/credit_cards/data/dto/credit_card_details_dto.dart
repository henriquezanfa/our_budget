import 'package:ob/features/credit_cards/domain/model/credit_card.dart';

class CreditCardDetailsDto {
  CreditCardDetailsDto({
    required this.id,
    required this.description,
    required this.currency,
    required this.createdAt,
    required this.dueDate,
    required this.closingDate,
    required this.limit,
  });

  CreditCardDetailsDto.fromBankAccount(CreditCard creditCard)
      : id = creditCard.id,
        description = creditCard.description,
        currency = creditCard.currency,
        createdAt = creditCard.createdAt,
        dueDate = creditCard.dueDate,
        closingDate = creditCard.closingDate,
        limit = creditCard.limit;

  final String id;
  final String description;
  final String currency;
  final int dueDate;
  final int closingDate;
  final double limit;
  final DateTime createdAt;

  CreditCard toCreditCard(String userId, String id) {
    return CreditCard(
      id: id,
      userId: userId,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      description: description,
      currency: currency,
      dueDate: dueDate,
      closingDate: closingDate,
      limit: limit,
    );
  }
}
