import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';

class AccountCreationDto {
  AccountCreationDto({
    required this.name,
    required this.currency,
    required this.accountType,
    required this.accountHolderName,
  });
  final String name;
  final String currency;
  final String accountType;
  final String accountHolderName;

  BankAccount toBankAccount(String userId, String id) {
    return BankAccount(
      id: id,
      userId: userId,
      name: name,
      currency: currency,
      accountType: accountType,
      accountHolderName: accountHolderName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
