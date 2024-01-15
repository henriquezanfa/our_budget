import 'package:ob/core/di/di.dart';
import 'package:ob/features/balance/data/data_source/balance_data_source.dart';
import 'package:ob/features/balance/data/repository/balance_repository.dart';

void injectBalance() {
  inject
    ..registerLazySingleton<BalanceDataSource>(
      () => BalanceDataSource(firestore: inject()),
    )
    ..registerLazySingleton<BalanceRepository>(
      () => BalanceRepository(dataSource: inject()),
    );
}
