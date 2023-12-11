// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountMemberRoleImpl _$$AccountMemberRoleImplFromJson(
        Map<String, dynamic> json) =>
    _$AccountMemberRoleImpl(
      email: json['email'] as String,
      permission:
          $enumDecode(_$AccountPermissionsEnumEnumMap, json['permission']),
      status: $enumDecode(_$AccountInviteStatusEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$$AccountMemberRoleImplToJson(
        _$AccountMemberRoleImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'permission': _$AccountPermissionsEnumEnumMap[instance.permission]!,
      'status': _$AccountInviteStatusEnumEnumMap[instance.status]!,
    };

const _$AccountPermissionsEnumEnumMap = {
  AccountPermissionsEnum.read: 'read',
  AccountPermissionsEnum.write: 'write',
  AccountPermissionsEnum.readWrite: 'readWrite',
  AccountPermissionsEnum.owner: 'owner',
  AccountPermissionsEnum.none: 'none',
};

const _$AccountInviteStatusEnumEnumMap = {
  AccountInviteStatusEnum.pending: 'pending',
  AccountInviteStatusEnum.accepted: 'accepted',
  AccountInviteStatusEnum.rejected: 'rejected',
  AccountInviteStatusEnum.expired: 'expired',
};
