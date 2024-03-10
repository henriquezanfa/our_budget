import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/core/di/di.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';
import 'package:ob/features/credit_cards/presentations/bloc/credit_card_bloc.dart';

class CreditCardDetailsWidget extends StatelessWidget {
  const CreditCardDetailsWidget({
    required this.creditCard,
    super.key,
  });
  final CreditCard creditCard;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreditCardBloc(inject()),
      child: CreditCardDetailsView(
        creditCard: creditCard,
      ),
    );
  }
}

class CreditCardDetailsView extends StatefulWidget {
  const CreditCardDetailsView({
    required this.creditCard,
    super.key,
  });

  final CreditCard creditCard;

  @override
  State<CreditCardDetailsView> createState() => _CreditCardDetailsWidgetState();
}

class _CreditCardDetailsWidgetState extends State<CreditCardDetailsView> {
  final _currencyController = TextEditingController();
  final _accountHolderNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _currencyController.text = widget.creditCard.currency;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreditCardBloc, CreditCardState>(
      listener: (context, state) {
        if (state is CreditCardMemberInvited) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Member invited'),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: _accountHolderNameController,
                  decoration: const InputDecoration(
                    hintText: 'Holder name',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _currencyController,
                  decoration: const InputDecoration(
                    hintText: 'Currency',
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
