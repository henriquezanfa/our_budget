import 'package:ob/domain/models/money_transaction/money_transaction.dart';

class MoneyTransactionDto {
  MoneyTransactionDto({
    required this.date,
    required this.amount,
    required this.isPaid,
    this.description,
    this.creditCardId,
    this.accountId,
  }) : assert(
          creditCardId != null || accountId != null,
          'Either creditCardId or accountId must be provided',
        );

  final DateTime date;
  final double amount;
  final bool isPaid;
  final String? description;
  final String? creditCardId;
  final String? accountId;

  MoneyTransaction toMoneyTransaction(String userId, String id) {
    return MoneyTransaction(
      id: id,
      userId: userId,
      amount: amount,
      date: date,
      isPaid: isPaid,
      description: description,
      creditCardId: creditCardId,
      accountId: accountId,
    );
  }
}
