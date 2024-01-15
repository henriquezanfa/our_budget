import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/features/categories/data/repositories/categories_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(this._categoriesRepository) : super(CategoriesInitial()) {
    on<GetCategories>(_onGetCategories);
    on<AddCategory>(_onAddCategory);
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
    await _categoriesRepository.addCategory(event.category).then((value) {
      value.fold(
        (l) => emit(CategoriesError(l)),
        (r) => emit(CategoriesAdded()),
      );  
    });
  }
}
