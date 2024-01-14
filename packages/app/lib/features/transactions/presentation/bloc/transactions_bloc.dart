import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/features/transactions/data/dto/money_transaction_dto.dart';
import 'package:ob/features/transactions/data/repository/transactions_repository.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc(this._repository) : super(TransactionsInitial()) {
    on<GetAccountsAndCategoriesEvent>(_onGetAccountsAndCategoriesEvent);
    on<CreateTransaction>(_onCreateTransaction);
  }

  final TransactionsRepository _repository;

  FutureOr<void> _onGetAccountsAndCategoriesEvent(
    GetAccountsAndCategoriesEvent event,
    Emitter<TransactionsState> emit,
  ) {
    emit(
      AccountsAndCategoriesState(
        accounts: const ['kik', 'ma'],
        categories: const ['Rent', 'Groceries', 'Restaurants'],
      ),
    );
  }

  FutureOr<void> _onCreateTransaction(
    CreateTransaction event,
    Emitter<TransactionsState> emit,
  ) async {
    if (event.account == null) {
      emit(TransactionsError('Account can not be null'));
      return;
    } else if (event.amount == null) {
      emit(TransactionsError('Amount can not be null'));
      return;
    } else if (event.category == null) {
      emit(TransactionsError('Category can not be null'));
      return;
    } else if (event.date == null) {
      emit(TransactionsError('Date can not be null'));
      return;
    } else if (event.description == null || event.description!.isEmpty) {
      emit(TransactionsError('Description can not be null'));
      return;
    }

    await _repository.createTransaction(
      MoneyTransactionDto(
        amount: event.amount!,
        date: event.date!,
        accountId: event.account!,
        description: event.description,
      ),
    );
  }
}
