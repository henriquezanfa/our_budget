import 'package:ob/domain/models/member/member.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';

class BankAccountCreationDto {
  BankAccountCreationDto({
    required this.name,
    required this.currency,
    required this.accountType,
    required this.accountHolderName,
  });
  final String name;
  final String currency;
  final AccountTypeEnum accountType;
  final String accountHolderName;

  BankAccount toBankAccount(
    String userId,
    String id, 
    List<Member> members,
  ) {
    return BankAccount(
      id: id,
      userId: userId,
      name: name,
      currency: currency,
      accountType: accountType,
      accountHolderName: accountHolderName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      members: members,
    );
  }
}
