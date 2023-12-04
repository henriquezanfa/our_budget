import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:ob/features/bank_accounts/inject.dart';

final inject = GetIt.instance;

void registerDependencies() {
  inject.registerLazySingleton(() => FirebaseFirestore.instance);

  registerBankAccountsDependencies();
}
