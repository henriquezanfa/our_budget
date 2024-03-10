import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';
import 'package:ob/features/categories/data/data_source/categories_data_source.dart';
import 'package:ob/features/categories/data/dto/transaction_category_dto.dart';
import 'package:ob/features/space/data/space_repository.dart';
import 'package:uuid/uuid.dart';

class CategoriesRepository {
  CategoriesRepository({
    required CategoriesDataSource remoteDataSource,
    required SpaceRepository spaceRepository,
  })  : _spaceRepository = spaceRepository,
        _remoteDataSource = remoteDataSource;
  final CategoriesDataSource _remoteDataSource;
  final SpaceRepository _spaceRepository;

  Future<Either<OBError, List<TransactionCategory>>> getCategories() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final categories = await _remoteDataSource.getCategories(
        userId: userId,
        spaceId: _spaceRepository.getCurrentSpaceId(),
      );
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

  Future<Either<OBError, void>> addCategory(TransactionCategoryDto dto) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final id = const Uuid().v4();
      final category = dto.toTransactionCategory(userId, id);
      final spaceId = _spaceRepository.getCurrentSpaceId();
      await _remoteDataSource.addCategory(
        spaceId: spaceId,
        category: category,
      );
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

  Future<Either<OBError, void>> updateCategory(
    TransactionCategory category,
  ) async {
    try {
      final spaceId = _spaceRepository.getCurrentSpaceId();

      await _remoteDataSource.updateCategory(
        spaceId: spaceId,
        category: category,
      );
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
