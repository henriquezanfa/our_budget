import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_category.freezed.dart';
part 'transaction_category.g.dart';

@freezed
class TransactionCategory with _$TransactionCategory {
  factory TransactionCategory({
    required String id,
    required String name,
    required String icon,
    required String userId,
  }) = _TransactionCategory;

  factory TransactionCategory.fromJson(Map<String, dynamic> json) =>
      _$TransactionCategoryFromJson(json);
}
