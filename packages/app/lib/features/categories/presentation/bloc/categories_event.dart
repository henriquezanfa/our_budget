part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}

final class GetCategories extends CategoriesEvent {}

final class AddCategory extends CategoriesEvent {
  AddCategory({
    required this.category,
    required this.monthlyTarget,
    required this.isSaving,
  });
  final String category;
  final double monthlyTarget;
  final bool isSaving;
}

final class UpdateCategory extends CategoriesEvent {
  UpdateCategory(this.category);
  final TransactionCategory category;
}
