import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/features/categories/data/dto/transaction_category_dto.dart';
import 'package:ob/features/categories/presentation/categories_colors.dart';
import 'package:ob/features/categories/presentation/widgets/category_item_widget.dart';
import 'package:ob/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:ob/ui/widgets/widgets.dart';

class CreateCategoriesPage extends StatefulWidget {
  const CreateCategoriesPage({super.key});

  @override
  State<CreateCategoriesPage> createState() => _CreateCategoriesPageState();
}

class _CreateCategoriesPageState extends State<CreateCategoriesPage> {
  final _defaultCategories = [
    TransactionCategoryDto(
      description: 'Supermarket',
      icon: '',
      monthlyTarget: 200,
      isSaving: false,
      color: categoriesColors.keys.toList()[0],
    ),
    TransactionCategoryDto(
      description: 'Rent',
      icon: '',
      monthlyTarget: 1000,
      isSaving: false,
      color: categoriesColors.keys.toList()[1],
    ),
    TransactionCategoryDto(
      description: 'Transport',
      icon: '',
      monthlyTarget: 100,
      isSaving: false,
      color: categoriesColors.keys.toList()[2],
    ),
    TransactionCategoryDto(
      description: 'Health',
      icon: '',
      monthlyTarget: 50,
      isSaving: false,
      color: categoriesColors.keys.toList()[3],
    ),
    TransactionCategoryDto(
      description: 'Entertainment',
      icon: '',
      monthlyTarget: 100,
      isSaving: false,
      color: categoriesColors.keys.toList()[4],
    ),
    TransactionCategoryDto(
      description: 'Investment',
      icon: '',
      monthlyTarget: 100,
      isSaving: true,
      color: categoriesColors.keys.toList()[5],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Step 2 - Create categories',
                      style: theme.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Categories help you organize your budget.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'You can choose from the default categories below or create your own later on the app.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _defaultCategories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final category = _defaultCategories[index];
                    return CategoryItemWidget(
                      dense: true,
                      category: category.toTransactionCategory('', ''),
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OBTextButton(
                text: 'I will create my own categories later',
                onPressed: () {
                  context.push(
                    '${OBRoutes.onboarding}/${OBRoutes.loading}',
                  );
                },
              ),
              OBElevatedButton(
                onPressed: () {
                  for (final category in _defaultCategories) {
                    context.read<OnboardingCubit>().addCategory(category);
                  }
                  context.push(
                    '${OBRoutes.onboarding}/${OBRoutes.loading}',
                  );
                },
                text: 'Use default categories',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
