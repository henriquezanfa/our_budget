import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/features/space/data/space_repository.dart';
import 'package:ob/features/transactions/data/data_source/transactions_data_source.dart';
import 'package:ob/features/transactions/data/dto/money_transaction_dto.dart';
import 'package:uuid/uuid.dart';

class TransactionsRepository {
  TransactionsRepository({
    required TransactionsDataSource dataSource,
    required SpaceRepository spaceRepository,
  })  : _dataSource = dataSource,
        _spaceRepository = spaceRepository;

  final TransactionsDataSource _dataSource;
  final SpaceRepository _spaceRepository;

  Stream<List<MoneyTransaction>> getTransactions() {
    return _dataSource.getTransactions;
  }

  Future<Either<OBError, void>> createTransaction(
    MoneyTransactionDto transactionDto,
  ) async {
    try {
      const uuid = Uuid();
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final id = uuid.v4();

      final transaction = transactionDto.toMoneyTransaction(userId, id);

      await _dataSource.createTransaction(
        spaceId: _spaceRepository.getCurrentSpaceId(),
        transaction: transaction,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(
        OBError(
          message: e.toString(),
          userMessage: ErrorMessages.couldNotCreateTransaction,
        ),
      );
    }
  }

  Future<Either<OBError, void>> updateTransaction(
    MoneyTransactionDto transactionDto,
    String transactionId,
  ) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final transaction = transactionDto.toMoneyTransaction(
        userId,
        transactionId,
      );

      await _dataSource.updateTransaction(
        spaceId: _spaceRepository.getCurrentSpaceId(),
        transaction: transaction,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(
        OBError(
          message: e.toString(),
          userMessage: ErrorMessages.couldNotUpdateTransaction,
        ),
      );
    }
  }

  Future<Either<OBError, void>> deleteTransaction(
    String transactionId,
  ) async {
    try {
      await _dataSource.deleteTransaction(
        spaceId: _spaceRepository.getCurrentSpaceId(),
        transactionId: transactionId,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(
        OBError(
          message: e.toString(),
          userMessage: ErrorMessages.couldNotDeleteTransaction,
        ),
      );
    }
  }
}
