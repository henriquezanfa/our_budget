// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankAccountImpl _$$BankAccountImplFromJson(Map<String, dynamic> json) =>
    _$BankAccountImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      currency: json['currency'] as String,
      accountType: $enumDecode(_$AccountTypeEnumEnumMap, json['accountType']),
      accountHolderName: json['accountHolderName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      members: (json['members'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      invitedMembersEmails: (json['invitedMembersEmails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$BankAccountImplToJson(_$BankAccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'currency': instance.currency,
      'accountType': _$AccountTypeEnumEnumMap[instance.accountType]!,
      'accountHolderName': instance.accountHolderName,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'members': instance.members.map((e) => e.toJson()).toList(),
      'invitedMembersEmails': instance.invitedMembersEmails,
    };

const _$AccountTypeEnumEnumMap = {
  AccountTypeEnum.current: 'current',
  AccountTypeEnum.savings: 'savings',
  AccountTypeEnum.salary: 'salary',
  AccountTypeEnum.other: 'other',
};
