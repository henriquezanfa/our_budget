import 'package:ob/core/di/di.dart';
import 'package:ob/features/categories/data/data_source/categories_data_source.dart';
import 'package:ob/features/categories/data/repositories/categories_repository.dart';

void injectCategories() {
  inject
    ..registerLazySingleton<CategoriesDataSource>(
      () => CategoriesDataSource(firestore: inject()),
    )
    ..registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepository(remoteDataSource: inject()),
    );
}
