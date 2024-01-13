// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MoneyTransactionImpl _$$MoneyTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$MoneyTransactionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      isPaid: json['isPaid'] as bool,
      description: json['description'] as String?,
      creditCardId: json['creditCardId'] as String?,
      accountId: json['accountId'] as String?,
    );

Map<String, dynamic> _$$MoneyTransactionImplToJson(
        _$MoneyTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'isPaid': instance.isPaid,
      'description': instance.description,
      'creditCardId': instance.creditCardId,
      'accountId': instance.accountId,
    };
