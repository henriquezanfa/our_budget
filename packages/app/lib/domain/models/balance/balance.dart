import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance.freezed.dart';
part 'balance.g.dart';

@freezed
class Balance with _$Balance {
  factory Balance({
    required double balance,
    required double incomes,
    required double outcomes,
  }) = _Balance;

  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);

  factory Balance.empty() => Balance(
        balance: 0,
        incomes: 0,
        outcomes: 0,
      );
}
