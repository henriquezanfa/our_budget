import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class CreateCategoriesPage extends StatefulWidget {
  const CreateCategoriesPage({super.key});

  @override
  State<CreateCategoriesPage> createState() => _CreateCategoriesPageState();
}

class _CreateCategoriesPageState extends State<CreateCategoriesPage> {
  late final TextEditingController _categoryNameController;
  late final FocusNode _categoryNameFocusNode;
  final List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _categoryNameController = TextEditingController();
    _categoryNameFocusNode = FocusNode();

    _categoryNameFocusNode.requestFocus();
    _categoryNameController.addListener(() {
      setState(() {});
    });
  }

  bool get _isFormValid =>
      _categoryNameController.text.isNotEmpty &&
      _categoryNameController.text.length > 3;

  void _addCategory() {
    if (_isFormValid) {
      setState(() {
        _categories.add(_categoryNameController.text);
        _categoryNameController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
                    'Step 3 - Create categories',
                    style: theme.textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Categories help you organize your budget. Create a few categories to get started.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      focusNode: _categoryNameFocusNode,
                      controller: _categoryNameController,
                      decoration: const InputDecoration(
                        labelText: 'Category name',
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _isFormValid ? _addCategory : null,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(_categories[index]),
                      trailing: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _categories.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _categories.isNotEmpty
                    ? () {
                        for (var category in _categories) {
                          context.read<OnboardingCubit>().addCategory(category);
                        }
                        context.push(
                          '${OBRoutes.onboarding}/${OBRoutes.loading}',
                        );
                      }
                    : null,
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
