part of 'onboarding_cubit.dart';

@immutable
class OnboardingState {
  const OnboardingState({
    this.spaceName = '',
    this.categories = const [],
    this.bankAccounts,
  });
  final String spaceName;
  final List<TransactionCategoryDto> categories;
  final BankAccount? bankAccounts;

  OnboardingState copyWith({
    String? spaceName,
    List<TransactionCategoryDto>? categories,
    BankAccount? bankAccounts,
  }) {
    return OnboardingState(
      spaceName: spaceName ?? this.spaceName,
      categories: categories ?? this.categories,
      bankAccounts: bankAccounts ?? this.bankAccounts,
    );
  }
}

class BankAccount {
  BankAccount({
    required this.name,
    required this.currency,
    required this.accountType,
    required this.accountHolderName,
  });
  final String name;
  final String currency;
  final AccountTypeEnum accountType;
  final String accountHolderName;
}
