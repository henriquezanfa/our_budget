// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AccountMember _$AccountMemberFromJson(Map<String, dynamic> json) {
  return _AccountMemberRole.fromJson(json);
}

/// @nodoc
mixin _$AccountMember {
  String get email => throw _privateConstructorUsedError;
  AccountPermissionsEnum get permission => throw _privateConstructorUsedError;
  AccountInviteStatusEnum get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountMemberCopyWith<AccountMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountMemberCopyWith<$Res> {
  factory $AccountMemberCopyWith(
          AccountMember value, $Res Function(AccountMember) then) =
      _$AccountMemberCopyWithImpl<$Res, AccountMember>;
  @useResult
  $Res call(
      {String email,
      AccountPermissionsEnum permission,
      AccountInviteStatusEnum status});
}

/// @nodoc
class _$AccountMemberCopyWithImpl<$Res, $Val extends AccountMember>
    implements $AccountMemberCopyWith<$Res> {
  _$AccountMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? permission = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      permission: null == permission
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as AccountPermissionsEnum,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AccountInviteStatusEnum,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountMemberRoleImplCopyWith<$Res>
    implements $AccountMemberCopyWith<$Res> {
  factory _$$AccountMemberRoleImplCopyWith(_$AccountMemberRoleImpl value,
          $Res Function(_$AccountMemberRoleImpl) then) =
      __$$AccountMemberRoleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      AccountPermissionsEnum permission,
      AccountInviteStatusEnum status});
}

/// @nodoc
class __$$AccountMemberRoleImplCopyWithImpl<$Res>
    extends _$AccountMemberCopyWithImpl<$Res, _$AccountMemberRoleImpl>
    implements _$$AccountMemberRoleImplCopyWith<$Res> {
  __$$AccountMemberRoleImplCopyWithImpl(_$AccountMemberRoleImpl _value,
      $Res Function(_$AccountMemberRoleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? permission = null,
    Object? status = null,
  }) {
    return _then(_$AccountMemberRoleImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      permission: null == permission
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as AccountPermissionsEnum,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AccountInviteStatusEnum,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountMemberRoleImpl implements _AccountMemberRole {
  _$AccountMemberRoleImpl(
      {required this.email, required this.permission, required this.status});

  factory _$AccountMemberRoleImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountMemberRoleImplFromJson(json);

  @override
  final String email;
  @override
  final AccountPermissionsEnum permission;
  @override
  final AccountInviteStatusEnum status;

  @override
  String toString() {
    return 'AccountMember(email: $email, permission: $permission, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountMemberRoleImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.permission, permission) ||
                other.permission == permission) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, permission, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountMemberRoleImplCopyWith<_$AccountMemberRoleImpl> get copyWith =>
      __$$AccountMemberRoleImplCopyWithImpl<_$AccountMemberRoleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountMemberRoleImplToJson(
      this,
    );
  }
}

abstract class _AccountMemberRole implements AccountMember {
  factory _AccountMemberRole(
      {required final String email,
      required final AccountPermissionsEnum permission,
      required final AccountInviteStatusEnum status}) = _$AccountMemberRoleImpl;

  factory _AccountMemberRole.fromJson(Map<String, dynamic> json) =
      _$AccountMemberRoleImpl.fromJson;

  @override
  String get email;
  @override
  AccountPermissionsEnum get permission;
  @override
  AccountInviteStatusEnum get status;
  @override
  @JsonKey(ignore: true)
  _$$AccountMemberRoleImplCopyWith<_$AccountMemberRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
