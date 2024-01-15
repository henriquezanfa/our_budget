// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionCategory _$TransactionCategoryFromJson(Map<String, dynamic> json) {
  return _TransactionCategory.fromJson(json);
}

/// @nodoc
mixin _$TransactionCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCategoryCopyWith<TransactionCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCategoryCopyWith<$Res> {
  factory $TransactionCategoryCopyWith(
          TransactionCategory value, $Res Function(TransactionCategory) then) =
      _$TransactionCategoryCopyWithImpl<$Res, TransactionCategory>;
  @useResult
  $Res call({String id, String name, String icon, String userId});
}

/// @nodoc
class _$TransactionCategoryCopyWithImpl<$Res, $Val extends TransactionCategory>
    implements $TransactionCategoryCopyWith<$Res> {
  _$TransactionCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionCategoryImplCopyWith<$Res>
    implements $TransactionCategoryCopyWith<$Res> {
  factory _$$TransactionCategoryImplCopyWith(_$TransactionCategoryImpl value,
          $Res Function(_$TransactionCategoryImpl) then) =
      __$$TransactionCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String icon, String userId});
}

/// @nodoc
class __$$TransactionCategoryImplCopyWithImpl<$Res>
    extends _$TransactionCategoryCopyWithImpl<$Res, _$TransactionCategoryImpl>
    implements _$$TransactionCategoryImplCopyWith<$Res> {
  __$$TransactionCategoryImplCopyWithImpl(_$TransactionCategoryImpl _value,
      $Res Function(_$TransactionCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? userId = null,
  }) {
    return _then(_$TransactionCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionCategoryImpl implements _TransactionCategory {
  _$TransactionCategoryImpl(
      {required this.id,
      required this.name,
      required this.icon,
      required this.userId});

  factory _$TransactionCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String icon;
  @override
  final String userId;

  @override
  String toString() {
    return 'TransactionCategory(id: $id, name: $name, icon: $icon, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionCategoryImplCopyWith<_$TransactionCategoryImpl> get copyWith =>
      __$$TransactionCategoryImplCopyWithImpl<_$TransactionCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionCategoryImplToJson(
      this,
    );
  }
}

abstract class _TransactionCategory implements TransactionCategory {
  factory _TransactionCategory(
      {required final String id,
      required final String name,
      required final String icon,
      required final String userId}) = _$TransactionCategoryImpl;

  factory _TransactionCategory.fromJson(Map<String, dynamic> json) =
      _$TransactionCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get icon;
  @override
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$$TransactionCategoryImplCopyWith<_$TransactionCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
