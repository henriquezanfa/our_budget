// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'money_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MoneyTransaction _$MoneyTransactionFromJson(Map<String, dynamic> json) {
  return _MoneyTransaction.fromJson(json);
}

/// @nodoc
mixin _$MoneyTransaction {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  MoneyTransactionType get type => throw _privateConstructorUsedError;
  TransactionCategory? get category => throw _privateConstructorUsedError;
  String get accountId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyTransactionCopyWith<MoneyTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyTransactionCopyWith<$Res> {
  factory $MoneyTransactionCopyWith(
          MoneyTransaction value, $Res Function(MoneyTransaction) then) =
      _$MoneyTransactionCopyWithImpl<$Res, MoneyTransaction>;
  @useResult
  $Res call(
      {String id,
      String userId,
      double amount,
      DateTime date,
      MoneyTransactionType type,
      TransactionCategory? category,
      String accountId,
      String? description});

  $TransactionCategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$MoneyTransactionCopyWithImpl<$Res, $Val extends MoneyTransaction>
    implements $MoneyTransactionCopyWith<$Res> {
  _$MoneyTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? amount = null,
    Object? date = null,
    Object? type = null,
    Object? category = freezed,
    Object? accountId = null,
    Object? description = freezed,
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MoneyTransactionType,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TransactionCategory?,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionCategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $TransactionCategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MoneyTransactionImplCopyWith<$Res>
    implements $MoneyTransactionCopyWith<$Res> {
  factory _$$MoneyTransactionImplCopyWith(_$MoneyTransactionImpl value,
          $Res Function(_$MoneyTransactionImpl) then) =
      __$$MoneyTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      double amount,
      DateTime date,
      MoneyTransactionType type,
      TransactionCategory? category,
      String accountId,
      String? description});

  @override
  $TransactionCategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$MoneyTransactionImplCopyWithImpl<$Res>
    extends _$MoneyTransactionCopyWithImpl<$Res, _$MoneyTransactionImpl>
    implements _$$MoneyTransactionImplCopyWith<$Res> {
  __$$MoneyTransactionImplCopyWithImpl(_$MoneyTransactionImpl _value,
      $Res Function(_$MoneyTransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? amount = null,
    Object? date = null,
    Object? type = null,
    Object? category = freezed,
    Object? accountId = null,
    Object? description = freezed,
  }) {
    return _then(_$MoneyTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MoneyTransactionType,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TransactionCategory?,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoneyTransactionImpl implements _MoneyTransaction {
  _$MoneyTransactionImpl(
      {required this.id,
      required this.userId,
      required this.amount,
      required this.date,
      required this.type,
      required this.category,
      required this.accountId,
      this.description});

  factory _$MoneyTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoneyTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final double amount;
  @override
  final DateTime date;
  @override
  final MoneyTransactionType type;
  @override
  final TransactionCategory? category;
  @override
  final String accountId;
  @override
  final String? description;

  @override
  String toString() {
    return 'MoneyTransaction(id: $id, userId: $userId, amount: $amount, date: $date, type: $type, category: $category, accountId: $accountId, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneyTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, amount, date, type,
      category, accountId, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneyTransactionImplCopyWith<_$MoneyTransactionImpl> get copyWith =>
      __$$MoneyTransactionImplCopyWithImpl<_$MoneyTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoneyTransactionImplToJson(
      this,
    );
  }
}

abstract class _MoneyTransaction implements MoneyTransaction {
  factory _MoneyTransaction(
      {required final String id,
      required final String userId,
      required final double amount,
      required final DateTime date,
      required final MoneyTransactionType type,
      required final TransactionCategory? category,
      required final String accountId,
      final String? description}) = _$MoneyTransactionImpl;

  factory _MoneyTransaction.fromJson(Map<String, dynamic> json) =
      _$MoneyTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  double get amount;
  @override
  DateTime get date;
  @override
  MoneyTransactionType get type;
  @override
  TransactionCategory? get category;
  @override
  String get accountId;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$MoneyTransactionImplCopyWith<_$MoneyTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
