import 'package:ob/domain/domain.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';

class CreditCardDetailsDto {
  CreditCardDetailsDto({
    required this.id,
    required this.name,
    required this.currency,
    required this.accountHolderName,
    required this.createdAt,
    required this.members,
  });

  CreditCardDetailsDto.fromBankAccount(CreditCard creditCard)
      : id = creditCard.id,
        name = creditCard.name,
        currency = creditCard.currency,
        accountHolderName = creditCard.accountHolderName,
        createdAt = creditCard.createdAt,
        members = creditCard.members ?? [];

  final String id;
  final String name;
  final String currency;
  final String accountHolderName;
  final DateTime createdAt;
  final List<Member> members;

  CreditCard toCreditCard(String userId, String id, DateTime dueDate) {
    return CreditCard(
      id: id,
      userId: userId,
      name: name,
      currency: currency,
      accountHolderName: accountHolderName,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      dueDate: dueDate,
      members: members,
    );
  }
}
