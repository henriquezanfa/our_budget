import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/domain/models/balance/balance.dart';
import 'package:ob/features/balance/data/repository/balance_repository.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc(this._repository) : super(BalanceInitial()) {
    on<GetBalance>(_onGetBalance);
  }

  final BalanceRepository _repository;

  FutureOr<void> _onGetBalance(
    GetBalance event,
    Emitter<BalanceState> emit,
  ) async {
    emit(BalanceLoading());

    await emit.forEach<Balance>(
      _repository.getBalance(),
      onData: (balance) => BalanceLoaded(balance: balance),
      onError: (error, _) => BalanceError(message: error.toString()),
    );
  }
}
