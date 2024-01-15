// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BalanceImpl _$$BalanceImplFromJson(Map<String, dynamic> json) =>
    _$BalanceImpl(
      balance: (json['balance'] as num).toDouble(),
      incomes: (json['incomes'] as num).toDouble(),
      outcomes: (json['outcomes'] as num).toDouble(),
    );

Map<String, dynamic> _$$BalanceImplToJson(_$BalanceImpl instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'incomes': instance.incomes,
      'outcomes': instance.outcomes,
    };
