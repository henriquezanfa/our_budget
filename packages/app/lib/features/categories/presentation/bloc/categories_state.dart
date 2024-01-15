part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoaded extends CategoriesState {
  CategoriesLoaded({required this.categories});

  final List<String> categories;
}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesError extends CategoriesState {
  CategoriesError(this.error);

  final OBError error;
}

final class CategoriesAdded extends CategoriesState {}
