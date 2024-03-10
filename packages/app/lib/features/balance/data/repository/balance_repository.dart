import 'package:firebase_auth/firebase_auth.dart';
import 'package:ob/domain/models/balance/balance.dart';
import 'package:ob/features/balance/data/data_source/balance_data_source.dart';
import 'package:ob/features/space/data/space_repository.dart';

class BalanceRepository {
  BalanceRepository({
    required BalanceDataSource dataSource,
    required SpaceRepository spaceRepository,
  })  : _dataSource = dataSource,
        _spaceRepository = spaceRepository;

  final BalanceDataSource _dataSource;
  final SpaceRepository _spaceRepository;

  Stream<Balance> getBalance(List<String> bankAccountsIds) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final spaceId = _spaceRepository.getCurrentSpaceId();

    return _dataSource.getBalance(
      spaceId: spaceId,
      userId: userId,
      bankAccountsIds: bankAccountsIds,
    );
  }
}
