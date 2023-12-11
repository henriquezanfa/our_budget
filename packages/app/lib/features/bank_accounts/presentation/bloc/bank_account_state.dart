part of 'bank_account_bloc.dart';

@immutable
sealed class BankAccountState {}

final class BankAccountInitial extends BankAccountState {}

final class BankAccountLoading extends BankAccountState {}

final class BankAccountLoaded extends BankAccountState {
  BankAccountLoaded(this.bankAccounts);
  final List<BankAccount> bankAccounts;
}

final class NoBankAccount extends BankAccountState {}

final class BankAccountError extends BankAccountState {
  BankAccountError(this.error);
  final OBError error;
}

final class BankAccountAdded extends BankAccountState {}

final class BankAccountMemberInvited extends BankAccountState {}
