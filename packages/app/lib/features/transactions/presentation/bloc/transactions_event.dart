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
    required this.type,
  });

  final double? amount;
  final String? description;
  final DateTime? date;
  final TransactionCategory? category;
  final String? account;
  final MoneyTransactionType? type;
}

final class DeleteTransaction extends TransactionsEvent {
  DeleteTransaction(this.id);

  final String id;
}

final class GetTransactions extends TransactionsEvent {
  GetTransactions();
}
