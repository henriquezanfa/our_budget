part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}

final class GetCategories extends CategoriesEvent {}

final class AddCategory extends CategoriesEvent {
  AddCategory(this.category);
  final String category;
}
