import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_transaction.freezed.dart';
part 'money_transaction.g.dart';

@freezed
class MoneyTransaction with _$MoneyTransaction {
  factory MoneyTransaction({
    required String id,
    required String userId,
    required double amount,
    required DateTime date,
    required bool isPaid,
    String? description,
    String? creditCardId,
    String? accountId,
  }) = _MoneyTransaction;

  factory MoneyTransaction.fromJson(Map<String, dynamic> json) =>
      _$MoneyTransactionFromJson(json);
}
