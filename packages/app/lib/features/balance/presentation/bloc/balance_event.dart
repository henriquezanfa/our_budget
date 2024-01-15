part of 'balance_bloc.dart';

@immutable
sealed class BalanceEvent {}

final class GetBalance extends BalanceEvent {}
