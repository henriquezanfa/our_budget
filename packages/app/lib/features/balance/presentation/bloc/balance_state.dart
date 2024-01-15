part of 'balance_bloc.dart';

@immutable
sealed class BalanceState {}

final class BalanceInitial extends BalanceState {}

final class BalanceLoaded extends BalanceState {
  BalanceLoaded({required this.balance});

  final Balance balance;
}

final class BalanceError extends BalanceState {
  BalanceError({required this.message});

  final String message;
}

final class BalanceLoading extends BalanceState {}
