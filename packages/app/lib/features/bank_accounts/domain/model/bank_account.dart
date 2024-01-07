import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/domain/domain.dart';

part 'bank_account.freezed.dart';
part 'bank_account.g.dart';

@freezed
class BankAccount with _$BankAccount {
  const factory BankAccount({
    required String id,
    required String userId,
    required String name,
    required String currency,
    required AccountTypeEnum accountType,
    required String accountHolderName,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<Member>? members,
  }) = _BankAccount;

  factory BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);
}
