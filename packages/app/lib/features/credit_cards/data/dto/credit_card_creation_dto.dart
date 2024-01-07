import 'package:ob/features/credit_cards/domain/model/credit_card.dart';

class CreditCardCreationDto {
  CreditCardCreationDto({
    required this.name,
    required this.currency,
    required this.accountHolderName,
    required this.dueDate,
  });
  final String name;
  final String currency;
  final String accountHolderName;
  final DateTime dueDate;

  CreditCard toCreditCard(String userId, String id) {
    return CreditCard(
      id: id,
      userId: userId,
      name: name,
      currency: currency,
      accountHolderName: accountHolderName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      dueDate: dueDate,
      members: [],
    );
  }
}
