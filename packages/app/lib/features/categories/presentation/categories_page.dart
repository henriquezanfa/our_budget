import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:ob/features/categories/presentation/widgets/add_new_category_button_widget.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesBloc(
        inject(),
      )..add(GetCategories()),
      child: const _CategoriesView(),
    );
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesAdded) {
          context.read<CategoriesBloc>().add(GetCategories());
        }
      },
      builder: (context, state) {
        var categories = <String>[];

        if (state is CategoriesLoaded) {
          categories = state.categories;
        }

        return OBScreen.secondary(
          title: 'Categories',
          slivers: [
            ...categories.map((e) {
              return SliverToBoxAdapter(child: ListTile(title: Text(e)));
            }),
            const SliverToBoxAdapter(
              child: AddNewCategoryButtonWidget(),
            ),
          ].withSpaceBetween(
            height: 16,
            isSliver: true,
          ),
        );
      },
    );
  }
}
