// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Balance _$BalanceFromJson(Map<String, dynamic> json) {
  return _Balance.fromJson(json);
}

/// @nodoc
mixin _$Balance {
  double get balance => throw _privateConstructorUsedError;
  double get incomes => throw _privateConstructorUsedError;
  double get outcomes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BalanceCopyWith<Balance> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceCopyWith<$Res> {
  factory $BalanceCopyWith(Balance value, $Res Function(Balance) then) =
      _$BalanceCopyWithImpl<$Res, Balance>;
  @useResult
  $Res call({double balance, double incomes, double outcomes});
}

/// @nodoc
class _$BalanceCopyWithImpl<$Res, $Val extends Balance>
    implements $BalanceCopyWith<$Res> {
  _$BalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? incomes = null,
    Object? outcomes = null,
  }) {
    return _then(_value.copyWith(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      incomes: null == incomes
          ? _value.incomes
          : incomes // ignore: cast_nullable_to_non_nullable
              as double,
      outcomes: null == outcomes
          ? _value.outcomes
          : outcomes // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceImplCopyWith<$Res> implements $BalanceCopyWith<$Res> {
  factory _$$BalanceImplCopyWith(
          _$BalanceImpl value, $Res Function(_$BalanceImpl) then) =
      __$$BalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double balance, double incomes, double outcomes});
}

/// @nodoc
class __$$BalanceImplCopyWithImpl<$Res>
    extends _$BalanceCopyWithImpl<$Res, _$BalanceImpl>
    implements _$$BalanceImplCopyWith<$Res> {
  __$$BalanceImplCopyWithImpl(
      _$BalanceImpl _value, $Res Function(_$BalanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? incomes = null,
    Object? outcomes = null,
  }) {
    return _then(_$BalanceImpl(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      incomes: null == incomes
          ? _value.incomes
          : incomes // ignore: cast_nullable_to_non_nullable
              as double,
      outcomes: null == outcomes
          ? _value.outcomes
          : outcomes // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BalanceImpl implements _Balance {
  _$BalanceImpl(
      {required this.balance, required this.incomes, required this.outcomes});

  factory _$BalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$BalanceImplFromJson(json);

  @override
  final double balance;
  @override
  final double incomes;
  @override
  final double outcomes;

  @override
  String toString() {
    return 'Balance(balance: $balance, incomes: $incomes, outcomes: $outcomes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.incomes, incomes) || other.incomes == incomes) &&
            (identical(other.outcomes, outcomes) ||
                other.outcomes == outcomes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, balance, incomes, outcomes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceImplCopyWith<_$BalanceImpl> get copyWith =>
      __$$BalanceImplCopyWithImpl<_$BalanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BalanceImplToJson(
      this,
    );
  }
}

abstract class _Balance implements Balance {
  factory _Balance(
      {required final double balance,
      required final double incomes,
      required final double outcomes}) = _$BalanceImpl;

  factory _Balance.fromJson(Map<String, dynamic> json) = _$BalanceImpl.fromJson;

  @override
  double get balance;
  @override
  double get incomes;
  @override
  double get outcomes;
  @override
  @JsonKey(ignore: true)
  _$$BalanceImplCopyWith<_$BalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
