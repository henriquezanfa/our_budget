import 'package:flutter/material.dart';
import 'package:ob/features/balance/presentation/balance_widget.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return OBScreen.primary(
      title: 'Hello, there 👋',
      actions: const [
        SelectSpaceButton(),
      ],
      children: [
        const SliverToBoxAdapter(
          child: BalanceWidget(),
        ),
      ].withSpaceBetween(
        height: 16,
        isSliver: true,
      ),
    );
  }
}

class SelectSpaceButton extends StatelessWidget {
  const SelectSpaceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings_outlined),
      onPressed: () {
        showOBModalBottomSheet<void>(
          context: context,
          child: const SelectSpaceModal(),
        );
      },
    );
  }
}

class SelectSpaceModal extends StatefulWidget {
  const SelectSpaceModal({
    super.key,
  });

  @override
  State<SelectSpaceModal> createState() => _SelectSpaceModalState();
}

class _SelectSpaceModalState extends State<SelectSpaceModal> {
  @override
  Widget build(BuildContext context) {
    return const Text('Hello, there 👋');
  }
}
