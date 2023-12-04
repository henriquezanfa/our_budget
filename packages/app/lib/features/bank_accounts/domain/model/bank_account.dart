import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_account.freezed.dart';
part 'bank_account.g.dart';

@freezed
class BankAccount with _$BankAccount {
  const factory BankAccount({
    required String id,
    required String userId,
    required String name,
    required String currency,
    required String accountType,
    required String accountHolderName,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BankAccount;

  factory BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);
}
