import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ob/app/view/restart_app.dart';
import 'package:ob/features/balance/presentation/balance_widget.dart';
import 'package:ob/features/space/data/space_repository.dart';
import 'package:ob/features/space/presentation/invitations_list.dart';
import 'package:ob/features/space/presentation/select_space_modal.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SpaceHandler(
      child: OBScreen.primary(
        title: 'Hello, there 👋',
        actions: const [SelectSpaceButton()],
        children: [
          const SliverToBoxAdapter(child: BalanceWidget()),
          const SliverToBoxAdapter(child: InvitationsList()),
        ].withSpaceBetween(height: 16, isSliver: true),
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
      onPressed: () => showChangeSpaceModal(context)
        ..then((restart) {
          if (restart == true) {
            RestartWidget.restartApp(context);
          }
        }),
    );
  }
}

class SpaceHandler extends StatefulWidget {
  const SpaceHandler({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  State<SpaceHandler> createState() => _SpaceHandlerState();
}

class _SpaceHandlerState extends State<SpaceHandler> {
  late final Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = _setCurrentSpace();
  }

  Future<void> _setCurrentSpace() async {
    final repo = GetIt.instance<SpaceRepository>();
    final spaceId = repo.currentSpaceId;
    if (spaceId != null) return;

    final spaces = await repo.getSpaces();
    if (spaces.isEmpty) return;

    final space = spaces.first;
    await repo.setCurrentSpace(space.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return widget.child;
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
