import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/features/bank_accounts/data/data_source/back_account_data_source.dart';
import 'package:ob/features/bank_accounts/data/dto/bank_account_creation_dto.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';
import 'package:ob/features/space/data/space_repository.dart';
import 'package:uuid/uuid.dart';

class BankAccountRepository {
  BankAccountRepository({
    required BankAccountDataSource bankAccountDataSource,
    required SpaceRepository spaceRepository,
  })  : _bankAccountDataSource = bankAccountDataSource,
        _spaceRepository = spaceRepository;

  final BankAccountDataSource _bankAccountDataSource;
  final SpaceRepository _spaceRepository;

  Future<Either<OBError, List<BankAccount>>> getBankAccounts() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final bankAccounts = await _bankAccountDataSource.getBankAccounts(
        userId: userId,
        spaceId: _spaceRepository.currentSpaceId!,
      );
      return right(bankAccounts);
    } catch (e) {
      debugPrint(e.toString());
      return left(
        OBError(
          userMessage: ErrorMessages.somethingWentWrong,
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<OBError, void>> addBankAccount(
    BankAccountCreationDto accountCreationDto,
  ) async {
    try {
      const uuid = Uuid();

      final userId = FirebaseAuth.instance.currentUser!.uid;
      final id = uuid.v4();

      final spaceId = _spaceRepository.currentSpaceId;

      final bankAccount = accountCreationDto.toBankAccount(userId, id);

      await _bankAccountDataSource.createBankAccount(
        bankAccount: bankAccount,
        spaceId: spaceId!,
      );

      return right(null);
    } catch (e) {
      return left(
        OBError(
          userMessage: ErrorMessages.somethingWentWrong,
          message: e.toString(),
        ),
      );
    }
  }
}
