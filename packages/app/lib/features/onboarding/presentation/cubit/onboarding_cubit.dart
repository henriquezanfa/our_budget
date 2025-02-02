import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/features/categories/data/dto/transaction_category_dto.dart';
import 'package:ob/features/onboarding/data/repository/onboarding_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._repository) : super(const OnboardingState());

  final OnboardingRepository _repository;

  void setSpaceName(String spaceName) {
    emit(state.copyWith(spaceName: spaceName));
  }

  void addCategory(TransactionCategoryDto category) {
    final updatedCategories =
        List<TransactionCategoryDto>.from(state.categories)..add(category);
    emit(state.copyWith(categories: updatedCategories));
  }

  void addBankAccount(BankAccount bankAccount) {
    emit(state.copyWith(bankAccounts: bankAccount));
  }

  Future<void> saveData() async {
    try {
      await _repository.setupAccount(
        spaceName: state.spaceName,
        accountName: state.bankAccounts?.name ?? 'bank account',
        currency: state.bankAccounts?.currency ?? 'USD',
        accountType: state.bankAccounts?.accountType ?? AccountTypeEnum.current,
        accountHolderName:
            state.bankAccounts?.accountHolderName ?? 'account holder',
        categories: state.categories,
      );
    } catch (e) {
      print(e);
    }
  }
}
