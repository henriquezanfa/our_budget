import 'package:ob/features/credit_cards/domain/model/credit_card.dart';

class CreditCardCreationDto {
  CreditCardCreationDto({
    required this.name,
    required this.currency,
    required this.dueDate,
    required this.closingDate,
    required this.limit,
  });
  final String name;
  final String currency;
  final int dueDate;
  final int closingDate;
  final double limit;

  CreditCard toCreditCard(String userId, String id) {
    return CreditCard(
      id: id,
      userId: userId,
      description: name,
      currency: currency,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      dueDate: dueDate,
      limit: limit,
      closingDate: closingDate,
    );
  }
}
