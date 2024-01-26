import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/credit_cards/presentations/bloc/credit_card_bloc.dart';
import 'package:ob/features/credit_cards/presentations/ui/widgets/create_credit_card.dart';
import 'package:ob/ui/widgets/ob_list_tile.dart';
import 'package:ob/ui/widgets/ob_screen.dart';

class CreditCardsListPage extends StatelessWidget {
  const CreditCardsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreditCardBloc(inject())..add(GetCreditCards()),
      child: const CreditCardsListPageView(),
    );
  }
}

class CreditCardsListPageView extends StatelessWidget {
  const CreditCardsListPageView({super.key});

  void _onRefresh(BuildContext context) {
    BlocProvider.of<CreditCardBloc>(context).add(GetCreditCards());
  }

  @override
  Widget build(BuildContext context) {
    return OBScreen.secondary(
      title: 'Credit Cards',
      onRefresh: () => _onRefresh(context),
      actions: [
        CreateCreditCard.icon(),
      ],
      children: const [
        SliverToBoxAdapter(child: CreditCardsList()),
        SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}

class CreditCardsList extends StatelessWidget {
  const CreditCardsList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreditCardBloc, CreditCardState>(
      listener: (context, state) {
        if (state is CreditCardError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.userMessage),
            ),
          );
        }

        if (state is CreditCardAdded) {
          BlocProvider.of<CreditCardBloc>(context).add(GetCreditCards());
        }
      },
      builder: (context, state) {
        if (state is CreditCardInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CreditCardLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.creditCards.length,
            itemBuilder: (context, index) {
              final creditCard = state.creditCards[index];
              return OBListTile(
                onTap: () {
                  context.push(
                    OBRoutes.creditCardDetails,
                    extra: creditCard,
                  );
                },
                title: creditCard.description,
              );
            },
          );
        } else if (state is NoCreditCard) {
          return const Center(
            child: Text('No bank account'),
          );
        } else if (state is CreditCardError) {
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
