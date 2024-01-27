import 'package:ob/core/di/di.dart';
import 'package:ob/features/transactions/data/data_source/transactions_data_source.dart';
import 'package:ob/features/transactions/data/repository/transactions_repository.dart';

void injectTransactions() {
  inject
    ..registerLazySingleton<TransactionsDataSource>(
      () => TransactionsDataSource(
        firestore: inject(),
        bankAccountDataSource: inject(),
      ),
    )
    ..registerLazySingleton<TransactionsRepository>(
      () => TransactionsRepository(dataSource: inject()),
    );
}
