import 'package:ob/domain/models/transaction_category/transaction_category.dart';

class TransactionCategoryDto {
  TransactionCategoryDto({
    required this.description,
    required this.icon,
    required this.monthlyTarget,
    required this.isSaving,
  });

  final String description;
  final String icon;
  final double monthlyTarget;
  final bool isSaving;

  TransactionCategory toTransactionCategory(String userId, String id) {
    return TransactionCategory(
      id: id,
      userId: userId,
      name: description,
      icon: icon,
      monthlyTarget: monthlyTarget,
      isSaving: isSaving,
    );
  }
}
