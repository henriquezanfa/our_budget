part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}

final class AccountsAndCategoriesState extends TransactionsState {
  AccountsAndCategoriesState({
    required this.accounts,
    required this.categories,
  });

  final List<String> accounts;
  final List<String> categories;
}

final class TransactionsError extends TransactionsState {
  TransactionsError(this.error);

  final String error;
}

final class TransactionsLoaded extends TransactionsState {
  TransactionsLoaded({required this.transactions});

  final List<MoneyTransaction> transactions;
}

final class TransactionCreated extends TransactionsState {}
