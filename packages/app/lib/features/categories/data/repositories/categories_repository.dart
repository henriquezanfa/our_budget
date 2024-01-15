import 'package:fpdart/fpdart.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/features/categories/data/data_source/categories_data_source.dart';

class CategoriesRepository {
  CategoriesRepository({required this.remoteDataSource});
  final CategoriesDataSource remoteDataSource;

  Future<Either<OBError, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return left(
        OBError(
          userMessage: ErrorMessages.somethingWentWrong,
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<OBError, void>> addCategory(String category) async {
    try {
      await remoteDataSource.addCategory(category);
      return const Right(null);
    } catch (e) {
      return left(
        OBError(
          userMessage: ErrorMessages.somethingWentWrong,
          message: e.toString(),
        ),
      );
    }
  }
}
