import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance.freezed.dart';
part 'balance.g.dart';

@freezed
class Balance with _$Balance {
  const factory Balance({
    required String id,
    required String userId,
    required String createdAt,
    required String updatedAt,
    required double amount,
  }) = _Balance;

  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);
}
