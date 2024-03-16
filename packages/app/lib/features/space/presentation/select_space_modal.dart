import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/space/presentation/bloc/space_bloc.dart';
import 'package:ob/ui/widgets/widgets.dart';

Future<bool?> showChangeSpaceModal(BuildContext context) async {
  return showOBModalBottomSheet<bool>(
    context: context,
    showDragHandle: false,
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SpaceBloc(inject())..add(GetSpaces()),
        ),
      ],
      child: const _ChangeSpaceModal(),
    ),
  );
}

class _ChangeSpaceModal extends StatelessWidget {
  const _ChangeSpaceModal();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Change Space', style: theme.textTheme.titleLarge),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<SpaceBloc, SpaceState>(
              builder: (context, state) {
                if (state is SpaceLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SpaceLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: state.spaces.length,
                    itemBuilder: (context, index) {
                      final space = state.spaces[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            color: Colors.grey[300],
                            child: space.imageUrl != null
                                ? Image.network(space.imageUrl!)
                                : const Icon(Icons.dashboard),
                          ),
                        ),
                        trailing: state.currentSpace?.id == space.id
                            ? const Icon(Icons.check)
                            : null,
                        title: Text(space.name),
                        onTap: () {
                          context.read<SpaceBloc>().add(ChangeSpace(space.id));
                          Navigator.of(context).pop(true);
                        },
                      );
                    },
                  );
                }
                return const Center(
                  child: Text('Error'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
