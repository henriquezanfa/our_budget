import 'package:firebase_auth/firebase_auth.dart';
import 'package:ob/domain/models/balance/balance.dart';
import 'package:ob/features/balance/data/data_source/balance_data_source.dart';

class BalanceRepository {
  BalanceRepository({required BalanceDataSource dataSource})
      : _dataSource = dataSource;

  final BalanceDataSource _dataSource;

  Stream<Balance> getBalance() {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return _dataSource.getBalance(userId);
  }
}
