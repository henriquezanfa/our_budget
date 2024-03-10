import 'package:ob/core/di/di.dart';
import 'package:ob/features/credit_cards/data/data_source/credit_card_data_source.dart';
import 'package:ob/features/credit_cards/data/repository/credit_card_repository.dart';

void registerCreditCardDependencies() {
  inject
    ..registerLazySingleton<CreditCardDataSource>(
      () => CreditCardDataSource(firestore: inject()),
    )
    ..registerLazySingleton<CreditCardRepository>(
      () => CreditCardRepository(
        creditCardDataSource: inject(),
        spaceRepository: inject(),
      ),
    );
}
