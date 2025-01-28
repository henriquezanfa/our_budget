import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/space/domain/space_model.dart';
import 'package:ob/features/space/presentation/bloc/space_bloc.dart';
import 'package:ob/ui/widgets/widgets.dart';

class InvitationsList extends StatelessWidget {
  const InvitationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpaceBloc(inject())
        ..add(
          GetInvitations(
            FirebaseAuth.instance.currentUser!.email!,
          ),
        ),
      child: const _InvitationsList(),
    );
  }
}

class _InvitationsList extends StatelessWidget {
  const _InvitationsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceBloc, SpaceState>(
      builder: (context, state) {
        if (state is SpaceLoading) {
          return const Center(
            child: Offstage(),
          );
        } else if (state is InvitationsLoaded && state.invitations.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invitations',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.invitations.length,
                itemBuilder: (context, index) {
                  final space = state.invitations[index];
                  return ListTile(
                    onTap: () {
                      showOBModalBottomSheet<bool>(
                        context: context,
                        child: AcceptOrDeclineInvitationModal(space: space),
                      ).then((accepted) {
                        if (accepted != null) {
                          context.read<SpaceBloc>().add(
                                ReplyToInvitation(
                                  space.id,
                                  accepted: accepted,
                                ),
                              );
                        }
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    title: Text(space.name),
                  );
                },
              ),
            ],
          );
        } else if (state is SpaceError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class AcceptOrDeclineInvitationModal extends StatelessWidget {
  const AcceptOrDeclineInvitationModal({
    required this.space,
    super.key,
  });

  final SpaceModel space;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You have been invited to join this space',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          OBElevatedButton(
            text: 'Accept',
            onPressed: () => Navigator.of(context).pop(true),
          ),
          OBTextButton(
            text: 'Decline',
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}
