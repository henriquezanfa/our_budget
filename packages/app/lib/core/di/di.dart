import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:ob/features/auth/data/auth_repository.dart';
import 'package:ob/features/balance/inject.dart';
import 'package:ob/features/bank_accounts/inject.dart';
import 'package:ob/features/categories/inject.dart';
import 'package:ob/features/credit_cards/inject.dart';
import 'package:ob/features/space/inject.dart';
import 'package:ob/features/transactions/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

final inject = GetIt.instance;

Future<void> registerDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  inject
    ..registerLazySingleton(() => sharedPreferences)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => AuthRepository(auth: inject<FirebaseAuth>()));

  // Must be called before any other feature dependencies
  // to ensure that the space is set before any other feature
  // and before the [SpaceRepository] is used.
  injectSpace();

  injectBankAccountsDependencies();
  injectBalance();
  registerCreditCardDependencies();
  injectTransactions();
  injectCategories();
}

void resetDependencies() {
  inject.reset();
  registerDependencies();
}
