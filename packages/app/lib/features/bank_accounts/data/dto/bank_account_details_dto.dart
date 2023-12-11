import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/features/bank_accounts/domain/model/account_member.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';

class BankAccountDetailsDto {
  BankAccountDetailsDto({
    required this.id,
    required this.name,
    required this.currency,
    required this.accountType,
    required this.accountHolderName,
    required this.createdAt,
    required this.members,
  });

  BankAccountDetailsDto.fromBankAccount(BankAccount bankAccount)
      : id = bankAccount.id,
        name = bankAccount.name,
        currency = bankAccount.currency,
        accountType = bankAccount.accountType,
        accountHolderName = bankAccount.accountHolderName,
        createdAt = bankAccount.createdAt,
        members = bankAccount.members ?? [];

  final String id;
  final String name;
  final String currency;
  final AccountTypeEnum accountType;
  final String accountHolderName;
  final DateTime createdAt;
  final List<AccountMember> members;

  BankAccount toBankAccount(String userId, String id) {
    return BankAccount(
      id: id,
      userId: userId,
      name: name,
      currency: currency,
      accountType: accountType,
      accountHolderName: accountHolderName,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      members: members,
    );
  }
}
