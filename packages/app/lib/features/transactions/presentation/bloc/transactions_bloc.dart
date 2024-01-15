import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/features/bank_accounts/data/repository/bank_account_repository.dart';
import 'package:ob/features/categories/data/repositories/categories_repository.dart';
import 'package:ob/features/transactions/data/dto/money_transaction_dto.dart';
import 'package:ob/features/transactions/data/repository/transactions_repository.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc(
    this._transactionsRepository,
    this._bankAccountRepository,
    this._categoriesRepository,
  ) : super(TransactionsInitial()) {
    on<GetAccountsAndCategoriesEvent>(_onGetAccountsAndCategoriesEvent);
    on<CreateTransaction>(_onCreateTransaction);
    on<GetTransactions>(_onGetTransactions);
  }

  final TransactionsRepository _transactionsRepository;
  final BankAccountRepository _bankAccountRepository;
  final CategoriesRepository _categoriesRepository;

  FutureOr<void> _onGetAccountsAndCategoriesEvent(
    GetAccountsAndCategoriesEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    final bankAccounts = await _bankAccountRepository.getBankAccounts().then(
      (value) {
        return value.fold(
          (l) => <String>[],
          (r) => r.map((e) => e.name),
        );
      },
    );

    final categories = await _categoriesRepository.getCategories().then(
      (value) {
        return value.fold(
          (l) => <String>[],
          (r) => r,
        );
      },
    );

    emit(
      AccountsAndCategoriesState(
        accounts: bankAccounts.toList(),
        categories: categories,
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

    await _transactionsRepository.createTransaction(
      MoneyTransactionDto(
        amount: event.amount!,
        date: event.date!,
        accountId: event.account!,
        description: event.description,
      ),
    );

    emit(TransactionCreated());
  }

  FutureOr<void> _onGetTransactions(
    GetTransactions event,
    Emitter<TransactionsState> emit,
  ) async {
    await emit.forEach<List<MoneyTransaction>>(
      _transactionsRepository.getTransactions(),
      onData: (transactions) => TransactionsLoaded(transactions: transactions),
      onError: (_, __) => TransactionsError('Error'),
    );
  }
}
