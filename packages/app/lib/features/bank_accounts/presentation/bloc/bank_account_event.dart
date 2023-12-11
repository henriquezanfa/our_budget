part of 'bank_account_bloc.dart';

@immutable
sealed class BankAccountEvent {}

class GetBankAccounts extends BankAccountEvent {
  GetBankAccounts();
}

class AddBankAccount extends BankAccountEvent {
  AddBankAccount(this.accountCreationDto);
  final BankAccountCreationDto accountCreationDto;
}

class InviteMember extends BankAccountEvent {
  InviteMember(this.accountId, this.email);
  final String accountId;
  final String email;
}
