// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
      email: json['email'] as String,
      userId: json['userId'] as String,
      permission: $enumDecode(_$PermissionsEnumEnumMap, json['permission']),
      status: $enumDecode(_$InviteStatusEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userId': instance.userId,
      'permission': _$PermissionsEnumEnumMap[instance.permission]!,
      'status': _$InviteStatusEnumEnumMap[instance.status]!,
    };

const _$PermissionsEnumEnumMap = {
  PermissionsEnum.read: 'read',
  PermissionsEnum.write: 'write',
  PermissionsEnum.readWrite: 'readWrite',
  PermissionsEnum.owner: 'owner',
  PermissionsEnum.none: 'none',
};

const _$InviteStatusEnumEnumMap = {
  InviteStatusEnum.pending: 'pending',
  InviteStatusEnum.accepted: 'accepted',
  InviteStatusEnum.rejected: 'rejected',
  InviteStatusEnum.expired: 'expired',
};
