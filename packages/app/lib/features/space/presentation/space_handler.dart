import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/space/presentation/cubit/space_cubit.dart';

class SpaceHandler extends StatelessWidget {
  const SpaceHandler({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpaceCubit>(
      create: (context) => SpaceCubit(inject()),
      child: _SpaceHandler(child: child),
    );
  }
}

class _SpaceHandler extends StatelessWidget {
  const _SpaceHandler({
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceCubit, SpaceState>(
      builder: (context, state) {
        return Container(
          // using ! because if state.currentSpace is null, the app will crash
          key: Key('space_handler_${state.currentSpace!.id}'),
          child: child,
        );
      },
    );
  }
}
