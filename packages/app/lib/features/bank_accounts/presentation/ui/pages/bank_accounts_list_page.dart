import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/bank_accounts/presentation/bloc/bank_account_bloc.dart';
import 'package:ob/features/bank_accounts/presentation/ui/modal/accept_invitation_modal.dart';
import 'package:ob/features/bank_accounts/presentation/ui/widgets/create_bank_account.dart';
import 'package:ob/ui/widgets/widgets.dart';

class BankAccountsListPage extends StatelessWidget {
  const BankAccountsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BankAccountBloc(inject())
        ..add(GetBankAccounts())
        ..add(GetInvitedBankAccounts()),
      child: const BankAccountsListPageView(),
    );
  }
}

class BankAccountsListPageView extends StatelessWidget {
  const BankAccountsListPageView({super.key});

  void _onRefresh(BuildContext context) {
    BlocProvider.of<BankAccountBloc>(context)
      ..add(GetBankAccounts())
      ..add(GetInvitedBankAccounts());
  }

  @override
  Widget build(BuildContext context) {
    return OBScreen.secondary(
      title: 'Bank Accounts',
      onRefresh: () => _onRefresh(context),
      actions: [
        CreateBankAccount.icon(),
      ],
      children: const [
        SliverToBoxAdapter(child: BankAccountsList()),
        SliverToBoxAdapter(child: InvitedBankAccountsList()),
      ],
    );
  }
}

class BankAccountsList extends StatelessWidget {
  const BankAccountsList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BankAccountBloc, BankAccountState>(
      listener: (context, state) {
        if (state is BankAccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.userMessage),
            ),
          );
        }

        if (state is BankAccountAdded) {
          BlocProvider.of<BankAccountBloc>(context).add(GetBankAccounts());
        }
      },
      builder: (context, state) {
        if (state is BankAccountInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BankAccountLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.bankAccounts.length,
            itemBuilder: (context, index) {
              final bankAccount = state.bankAccounts[index];
              return OBListTile(
                onTap: () {
                  context.push(
                    OBRoutes.bankAccountDetails,
                    extra: bankAccount,
                  );
                },
                title: bankAccount.name,
                subtitle: bankAccount.accountType.name,
              );
            },
          );
        } else if (state is NoBankAccount) {
          return const Center(
            child: Text('No bank account'),
          );
        } else if (state is BankAccountError) {
          return Center(
            child: Text(state.error.userMessage),
          );
        } else {
          return const Offstage();
        }
      },
    );
  }
}

class InvitedBankAccountsList extends StatelessWidget {
  const InvitedBankAccountsList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BankAccountBloc, BankAccountState>(
      builder: (context, state) {
        if (state is InvitedBankAccountLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invites',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.bankAccounts.length,
                itemBuilder: (context, index) {
                  final bankAccount = state.bankAccounts[index];
                  return OBListTile(
                    onTap: () {
                      showOBModalBottomSheet<bool>(
                        context: context,
                        child: AcceptInvitationModal(
                          bankAccount: bankAccount,
                        ),
                      ).then((value) {
                        if (value != null && value) {
                          context
                              .read<BankAccountBloc>()
                              .add(AcceptInvitation(bankAccount.id));
                        }
                      });
                    },
                    title: bankAccount.name,
                    subtitle: bankAccount.accountType.name,
                  );
                },
              ),
            ],
          );
        }
        return const Offstage();
      },
    );
  }
}
