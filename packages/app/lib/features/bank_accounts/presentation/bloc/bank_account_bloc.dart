import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/core/error/error.dart';
import 'package:ob/features/bank_accounts/data/dto/bank_account_creation_dto.dart';
import 'package:ob/features/bank_accounts/data/repository/bank_account_repository.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';

part 'bank_account_event.dart';
part 'bank_account_state.dart';

class BankAccountBloc extends Bloc<BankAccountEvent, BankAccountState> {
  BankAccountBloc(this._bankAccountRepository) : super(BankAccountInitial()) {
    on<GetBankAccounts>(_getBankAccounts);
    on<AddBankAccount>(_addBankAccount);
  }
  final BankAccountRepository _bankAccountRepository;

  FutureOr<void> _getBankAccounts(
    GetBankAccounts event,
    Emitter<BankAccountState> emit,
  ) async {
    emit(BankAccountLoading());
    await _bankAccountRepository.getBankAccounts().then((result) {
      result.fold(
        (error) => emit(BankAccountError(error)),
        (bankAccounts) {
          if (bankAccounts.isEmpty) {
            emit(NoBankAccount());
          } else {
            emit(BankAccountLoaded(bankAccounts));
          }
        },
      );
    });
  }

  FutureOr<void> _addBankAccount(
    AddBankAccount event,
    Emitter<BankAccountState> emit,
  ) async {
    emit(BankAccountLoading());
    await _bankAccountRepository.addBankAccount(event.accountCreationDto).then(
      (result) {
        result.fold(
          (error) => emit(BankAccountError(error)),
          (_) => emit(BankAccountAdded()),
        );
      },
    );
  }
}
