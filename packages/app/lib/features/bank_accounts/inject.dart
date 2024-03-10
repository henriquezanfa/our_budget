import 'package:ob/core/di/di.dart';
import 'package:ob/features/bank_accounts/data/data_source/back_account_data_source.dart';
import 'package:ob/features/bank_accounts/data/repository/bank_account_repository.dart';

void injectBankAccountsDependencies() {
  inject
    ..registerLazySingleton<BankAccountDataSource>(
      () => BankAccountDataSource(firestore: inject()),
    )
    ..registerLazySingleton<BankAccountRepository>(
      () => BankAccountRepository(
        bankAccountDataSource: inject(),
        spaceRepository: inject(),
      ),
    );
}
