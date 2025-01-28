import 'package:ob/features/auth/data/auth_repository.dart';
import 'package:ob/features/bank_accounts/data/dto/bank_account_creation_dto.dart';
import 'package:ob/features/bank_accounts/data/repository/bank_account_repository.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_type_enum.dart';
import 'package:ob/features/categories/data/dto/transaction_category_dto.dart';
import 'package:ob/features/categories/data/repositories/categories_repository.dart';
import 'package:ob/features/space/data/space_repository.dart';

class OnboardingRepository {
  OnboardingRepository({
    required SpaceRepository spaceRepository,
    required BankAccountRepository bankAccountRepository,
    required CategoriesRepository categoriesRepository,
    required AuthRepository authRepository,
  })  : _spaceRepository = spaceRepository,
        _bankAccountRepository = bankAccountRepository,
        _categoriesRepository = categoriesRepository,
        _authRepository = authRepository;

  final SpaceRepository _spaceRepository;
  final BankAccountRepository _bankAccountRepository;
  final CategoriesRepository _categoriesRepository;
  final AuthRepository _authRepository;

  Future<void> setupAccount({
    // space data
    required String spaceName,
    // bank account data
    required String accountName,
    required String currency,
    required AccountTypeEnum accountType,
    required String accountHolderName,
    // category data
    required List<String> categories,
  }) async {
    final userId = await _authRepository.signInAnonymously();

    await _spaceRepository.createSpace(userId, name: spaceName);

    await _bankAccountRepository.addBankAccount(
      BankAccountCreationDto(
        name: accountName,
        currency: currency,
        accountType: accountType,
        accountHolderName: accountHolderName,
      ),
    );

    await Future.wait(
      categories.map((category) {
        return _categoriesRepository.addCategory(
          TransactionCategoryDto(
            description: category,
            icon: '',
          ),
        );
      }),
    );
  }
}
