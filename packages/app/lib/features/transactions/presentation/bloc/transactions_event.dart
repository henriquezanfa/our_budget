part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

final class GetAccountsAndCategoriesEvent extends TransactionsEvent {}

final class CreateTransaction extends TransactionsEvent {
  CreateTransaction({
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
    required this.account,
  });

  final double? amount;
  final String? description;
  final DateTime? date;
  final String? category;
  final String? account;
}

final class GetTransactions extends TransactionsEvent {
  GetTransactions();
}
