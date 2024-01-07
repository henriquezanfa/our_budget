// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) {
  return _CreditCard.fromJson(json);
}

/// @nodoc
mixin _$CreditCard {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get accountHolderName => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  List<Member>? get members => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreditCardCopyWith<CreditCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditCardCopyWith<$Res> {
  factory $CreditCardCopyWith(
          CreditCard value, $Res Function(CreditCard) then) =
      _$CreditCardCopyWithImpl<$Res, CreditCard>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String currency,
      String accountHolderName,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime dueDate,
      List<Member>? members});
}

/// @nodoc
class _$CreditCardCopyWithImpl<$Res, $Val extends CreditCard>
    implements $CreditCardCopyWith<$Res> {
  _$CreditCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? currency = null,
    Object? accountHolderName = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? dueDate = null,
    Object? members = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      accountHolderName: null == accountHolderName
          ? _value.accountHolderName
          : accountHolderName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Member>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreditCardImplCopyWith<$Res>
    implements $CreditCardCopyWith<$Res> {
  factory _$$CreditCardImplCopyWith(
          _$CreditCardImpl value, $Res Function(_$CreditCardImpl) then) =
      __$$CreditCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String currency,
      String accountHolderName,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime dueDate,
      List<Member>? members});
}

/// @nodoc
class __$$CreditCardImplCopyWithImpl<$Res>
    extends _$CreditCardCopyWithImpl<$Res, _$CreditCardImpl>
    implements _$$CreditCardImplCopyWith<$Res> {
  __$$CreditCardImplCopyWithImpl(
      _$CreditCardImpl _value, $Res Function(_$CreditCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? currency = null,
    Object? accountHolderName = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? dueDate = null,
    Object? members = freezed,
  }) {
    return _then(_$CreditCardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      accountHolderName: null == accountHolderName
          ? _value.accountHolderName
          : accountHolderName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      members: freezed == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Member>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditCardImpl implements _CreditCard {
  _$CreditCardImpl(
      {required this.id,
      required this.userId,
      required this.name,
      required this.currency,
      required this.accountHolderName,
      required this.createdAt,
      required this.updatedAt,
      required this.dueDate,
      final List<Member>? members})
      : _members = members;

  factory _$CreditCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditCardImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final String currency;
  @override
  final String accountHolderName;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime dueDate;
  final List<Member>? _members;
  @override
  List<Member>? get members {
    final value = _members;
    if (value == null) return null;
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CreditCard(id: $id, userId: $userId, name: $name, currency: $currency, accountHolderName: $accountHolderName, createdAt: $createdAt, updatedAt: $updatedAt, dueDate: $dueDate, members: $members)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.accountHolderName, accountHolderName) ||
                other.accountHolderName == accountHolderName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      currency,
      accountHolderName,
      createdAt,
      updatedAt,
      dueDate,
      const DeepCollectionEquality().hash(_members));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditCardImplCopyWith<_$CreditCardImpl> get copyWith =>
      __$$CreditCardImplCopyWithImpl<_$CreditCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditCardImplToJson(
      this,
    );
  }
}

abstract class _CreditCard implements CreditCard {
  factory _CreditCard(
      {required final String id,
      required final String userId,
      required final String name,
      required final String currency,
      required final String accountHolderName,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime dueDate,
      final List<Member>? members}) = _$CreditCardImpl;

  factory _CreditCard.fromJson(Map<String, dynamic> json) =
      _$CreditCardImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  String get currency;
  @override
  String get accountHolderName;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime get dueDate;
  @override
  List<Member>? get members;
  @override
  @JsonKey(ignore: true)
  _$$CreditCardImplCopyWith<_$CreditCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
