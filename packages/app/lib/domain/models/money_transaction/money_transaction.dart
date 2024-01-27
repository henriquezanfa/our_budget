import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';

part 'money_transaction.freezed.dart';
part 'money_transaction.g.dart';

enum MoneyTransactionType {
  income('income'),
  outcome('outcome');

  const MoneyTransactionType(this.value);
  final String value;
}

@freezed
class MoneyTransaction with _$MoneyTransaction {
  factory MoneyTransaction({
    required String id,
    required String userId,
    required double amount,
    required DateTime date,
    required MoneyTransactionType type,
    required TransactionCategory? category,
    required String accountId,
    String? description,
  }) = _MoneyTransaction;

  factory MoneyTransaction.fromJson(Map<String, dynamic> json) =>
      _$MoneyTransactionFromJson(json);
}
