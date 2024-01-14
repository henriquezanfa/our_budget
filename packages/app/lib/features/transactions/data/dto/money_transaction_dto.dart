import 'package:ob/domain/models/money_transaction/money_transaction.dart';

class MoneyTransactionDto {
  MoneyTransactionDto({
    required this.date,
    required this.amount,
    required this.accountId,
    this.description,
  });

  final DateTime date;
  final double amount;
  final String? description;
  final String accountId;

  MoneyTransaction toMoneyTransaction(String userId, String id) {
    return MoneyTransaction(
      id: id,
      userId: userId,
      amount: amount,
      date: date,
      description: description,
      accountId: accountId,
    );
  }
}
