import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';

class MoneyTransactionDto {
  MoneyTransactionDto({
    required this.date,
    required this.amount,
    required this.accountId,
    required this.type,
    required this.category,
    this.description,
  });

  final DateTime date;
  final double amount;
  final String? description;
  final String accountId;
  final MoneyTransactionType type;
  final TransactionCategory category;

  MoneyTransaction toMoneyTransaction(String userId, String id) {
    return MoneyTransaction(
      id: id,
      userId: userId,
      amount: amount,
      type: type,
      date: date,
      description: description,
      accountId: accountId,
      category: category,
    );
  }
}
