import 'package:freezed_annotation/freezed_annotation.dart';

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
    String? description,
    String? accountId,
  }) = _MoneyTransaction;

  factory MoneyTransaction.fromJson(Map<String, dynamic> json) =>
      _$MoneyTransactionFromJson(json);
}
