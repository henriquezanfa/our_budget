import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/domain/domain.dart';
import 'package:ob/features/bank_accounts/data/data_source/back_account_data_source.dart';
import 'package:ob/features/bank_accounts/data/dto/bank_account_creation_dto.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';
import 'package:uuid/uuid.dart';

class BankAccountRepository {
  BankAccountRepository({required BankAccountDataSource bankAccountDataSource})
      : _bankAccountDataSource = bankAccountDataSource;

  final BankAccountDataSource _bankAccountDataSource;

  Future<Either<OBError, List<BankAccount>>> getBankAccounts() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final bankAccounts = await _bankAccountDataSource.getBankAccounts(userId);
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
      final owner = Member(
        userId: userId,
        email: FirebaseAuth.instance.currentUser!.email!,
        permission: PermissionsEnum.owner,
        status: InviteStatusEnum.accepted,
      );
      final bankAccount = accountCreationDto.toBankAccount(userId, id, [owner]);

      await _bankAccountDataSource.createBankAccount(bankAccount);
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

  Future<Either<OBError, void>> inviteMember(
    String bankAccountId,
    String inviteEmail,
  ) async {
    try {
      final accountMember = Member(
        userId: '',
        email: inviteEmail,
        permission: PermissionsEnum.readWrite,
        status: InviteStatusEnum.pending,
      );
      await _bankAccountDataSource.inviteMember(
        bankAccountId,
        accountMember,
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

  Future<Either<OBError, List<BankAccount>>> getInvitedBankAccounts() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.email!;
      final bankAccounts =
          await _bankAccountDataSource.getInvitedBankAccounts(userId);
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

  Future<Either<OBError, void>> acceptInvitation(
    String bankAccountId,
  ) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final userEmail = FirebaseAuth.instance.currentUser!.email!;
      await _bankAccountDataSource.acceptInvitation(
        bankAccountId,
        userId,
        userEmail,
      );
      return right(null);
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
}
