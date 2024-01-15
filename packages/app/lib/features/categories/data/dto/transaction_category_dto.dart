import 'package:ob/domain/models/transaction_category/transaction_category.dart';

class TransactionCategoryDto {
  TransactionCategoryDto({required this.description, required this.icon});

  final String description;
  final String icon;

  TransactionCategory toTransactionCategory(String userId, String id) {
    return TransactionCategory(
      id: id,
      userId: userId,
      name: description,
      icon: icon,
    );
  }
}
