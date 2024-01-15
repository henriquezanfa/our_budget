import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';
import 'package:ob/features/categories/data/dto/transaction_category_dto.dart';
import 'package:ob/features/categories/data/repositories/categories_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(this._categoriesRepository) : super(CategoriesInitial()) {
    on<GetCategories>(_onGetCategories);
    on<AddCategory>(_onAddCategory);
    on<UpdateCategory>(_onUpdateCategory);
  }

  final CategoriesRepository _categoriesRepository;

  FutureOr<void> _onGetCategories(
    GetCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());

    await _categoriesRepository.getCategories().then((value) {
      value.fold(
        (l) => emit(CategoriesError(l)),
        (r) => emit(CategoriesLoaded(categories: r)),
      );
    });
  }

  FutureOr<void> _onAddCategory(
    AddCategory event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    final dto = TransactionCategoryDto(description: event.category, icon: '');
    await _categoriesRepository.addCategory(dto).then((value) {
      value.fold(
        (l) => emit(CategoriesError(l)),
        (r) => emit(CategoriesAdded()),
      );
    });
  }

  FutureOr<void> _onUpdateCategory(
    UpdateCategory event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    await _categoriesRepository.updateCategory(event.category).then((value) {
      value.fold(
        (l) => emit(CategoriesError(l)),
        (r) => emit(CategoriesUpdated()),
      );
    });
  }
}
