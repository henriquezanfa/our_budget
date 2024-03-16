import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/space/presentation/bloc/space_bloc.dart';
import 'package:ob/ui/widgets/widgets.dart';

class SpaceDetailsScreen extends StatelessWidget {
  const SpaceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpaceBloc(inject())..add(GetSpaces()),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Space Details'),
      ),
      body: BlocConsumer<SpaceBloc, SpaceState>(
        listener: (context, state) {
          if (state is UserInvited) {
            context.read<SpaceBloc>().add(GetSpaces());
          }
        },
        builder: (context, state) {
          if (state is! SpaceLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final space = state.currentSpace!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Name'),
                  subtitle: Text(space.name),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Description'),
                  subtitle: Text(space.description ?? 'No description'),
                ),
                // users
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: space.users.length,
                  itemBuilder: (context, index) {
                    final user = space.users[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(user.name),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // invitations
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Invited users',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        showOBModalBottomSheet<String>(
                          context: context,
                          child: const _InviteUserModal(),
                        ).then((email) {
                          if (email != null) {
                            context.read<SpaceBloc>().add(InviteUser(email));
                          }
                        });
                      },
                      child: const Text('Add member'),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: space.invitedEmails?.length ?? 0,
                  itemBuilder: (context, index) {
                    final email = space.invitedEmails![index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(email),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InviteUserModal extends StatefulWidget {
  const _InviteUserModal();

  @override
  State<_InviteUserModal> createState() => _InviteUserModalState();
}

class _InviteUserModalState extends State<_InviteUserModal> {
  final _emailController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            focusNode: _focusNode,
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 20),
          OBElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(_emailController.text);
            },
            text: 'Invite',
          ),
        ],
      ),
    );
  }
}
