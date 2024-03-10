import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/domain/models/balance/balance.dart';
import 'package:ob/features/balance/data/repository/balance_repository.dart';
import 'package:ob/features/bank_accounts/data/repository/bank_account_repository.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc(
    this._repository,
    this._bankAccountRepository,
  ) : super(BalanceInitial()) {
    on<GetBalance>(_onGetBalance);
  }

  final BalanceRepository _repository;
  final BankAccountRepository _bankAccountRepository;

  FutureOr<void> _onGetBalance(
    GetBalance event,
    Emitter<BalanceState> emit,
  ) async {
    emit(BalanceLoading());

    final bankAccounts = await _bankAccountRepository.getBankAccounts().then(
          (value) => value.fold(
            (l) => <String>[],
            (r) => r.map((e) => e.id).toList(),
          ),
        );

    if (bankAccounts.isEmpty) {
      emit(BalanceLoaded(balance: Balance.empty()));
      return;
    }
    await emit.forEach<Balance>(
      _repository.getBalance(bankAccounts),
      onData: (balance) => BalanceLoaded(balance: balance),
      onError: (error, _) => BalanceError(message: error.toString()),
    );
  }
}
