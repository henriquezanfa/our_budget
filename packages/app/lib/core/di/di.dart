import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:ob/features/balance/inject.dart';
import 'package:ob/features/bank_accounts/inject.dart';
import 'package:ob/features/categories/inject.dart';
import 'package:ob/features/credit_cards/inject.dart';
import 'package:ob/features/transactions/inject.dart';

final inject = GetIt.instance;

void registerDependencies() {
  inject.registerLazySingleton(() => FirebaseFirestore.instance);

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
