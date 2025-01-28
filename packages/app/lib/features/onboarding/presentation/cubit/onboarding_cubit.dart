import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/features/onboarding/data/repository/onboarding_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._repository) : super(const OnboardingState());

  final OnboardingRepository _repository;

  void setSpaceName(String spaceName) {
    emit(state.copyWith(spaceName: spaceName));
  }

  void addCategory(String category) {
    final updatedCategories = List<String>.from(state.categories)
      ..add(category);
    emit(state.copyWith(categories: updatedCategories));
  }

  void addBankAccount(BankAccount bankAccount) {
    emit(state.copyWith(bankAccounts: bankAccount));
  }

  Future<void> saveData() async {
    try {
      await _repository.setupAccount(
        spaceName: state.spaceName,
        accountName: state.bankAccounts!.name,
        currency: state.bankAccounts!.currency,
        accountType: state.bankAccounts!.accountType,
        accountHolderName: state.bankAccounts!.accountHolderName,
        categories: state.categories,
      );
    } catch (e) {
      print(e);
    }
  }
}
