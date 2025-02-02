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
    required String color,
    double? monthlyTarget,

    /// Defines if the target is for saving or spending
    @Default(false) bool isSaving,
  }) = _TransactionCategory;
  
  const TransactionCategory._();

  factory TransactionCategory.fromJson(Map<String, dynamic> json) =>
      _$TransactionCategoryFromJson(json);

  bool get isTargetForSpending => !isSaving;

  bool get isTargetForSaving => isSaving;
}
