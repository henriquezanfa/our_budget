import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';

class BankAccountDetailsDto {
  BankAccountDetailsDto({
    required this.id,
    required this.name,
    required this.currency,
    required this.accountType,
    required this.accountHolderName,
    required this.createdAt,
  });

  BankAccountDetailsDto.fromBankAccount(BankAccount bankAccount)
      : id = bankAccount.id,
        name = bankAccount.name,
        currency = bankAccount.currency,
        accountType = bankAccount.accountType,
        accountHolderName = bankAccount.accountHolderName,
        createdAt = bankAccount.createdAt;

  final String id;
  final String name;
  final String currency;
  final AccountTypeEnum accountType;
  final String accountHolderName;
  final DateTime createdAt;

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
    );
  }
}
