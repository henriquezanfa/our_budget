import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/features/bank_accounts/data/data_source/back_account_data_source.dart';
import 'package:ob/features/bank_accounts/data/dto/bank_account_creation_dto.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_invite_status_enum.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_permissions_enum.dart';
import 'package:ob/features/bank_accounts/domain/model/account_member.dart';
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
      final bankAccount = accountCreationDto.toBankAccount(userId, id);

      final owner = AccountMember(
        email: FirebaseAuth.instance.currentUser!.email!,
        permission: AccountPermissionsEnum.owner,
        status: AccountInviteStatusEnum.accepted,
      );

      await _bankAccountDataSource.addBankAccount(bankAccount);
      await _bankAccountDataSource.addBankAccountMember(bankAccount.id, owner);
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
      final accountMember = AccountMember(
        email: inviteEmail,
        permission: AccountPermissionsEnum.readWrite,
        status: AccountInviteStatusEnum.pending,
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
}
