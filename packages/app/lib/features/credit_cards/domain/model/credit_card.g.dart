// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditCardImpl _$$CreditCardImplFromJson(Map<String, dynamic> json) =>
    _$CreditCardImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      description: json['description'] as String,
      currency: json['currency'] as String,
      limit: (json['limit'] as num).toDouble(),
      dueDate: json['dueDate'] as int,
      closingDate: json['closingDate'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CreditCardImplToJson(_$CreditCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'description': instance.description,
      'currency': instance.currency,
      'limit': instance.limit,
      'dueDate': instance.dueDate,
      'closingDate': instance.closingDate,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'members': instance.members?.map((e) => e.toJson()).toList(),
    };
