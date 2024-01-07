// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditCardImpl _$$CreditCardImplFromJson(Map<String, dynamic> json) =>
    _$CreditCardImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      currency: json['currency'] as String,
      accountHolderName: json['accountHolderName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CreditCardImplToJson(_$CreditCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'currency': instance.currency,
      'accountHolderName': instance.accountHolderName,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'dueDate': instance.dueDate.toIso8601String(),
      'members': instance.members,
    };
