// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionCategoryImpl _$$TransactionCategoryImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      userId: json['userId'] as String,
      monthlyTarget: (json['monthlyTarget'] as num?)?.toDouble(),
      isSaving: json['isSaving'] as bool? ?? false,
    );

Map<String, dynamic> _$$TransactionCategoryImplToJson(
        _$TransactionCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'userId': instance.userId,
      'monthlyTarget': instance.monthlyTarget,
      'isSaving': instance.isSaving,
    };
