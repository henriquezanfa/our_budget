import 'package:flutter/material.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';
import 'package:ob/features/credit_cards/presentations/ui/widgets/credit_card_details_widget.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class CreditCardDetailsPage extends StatelessWidget {
  const CreditCardDetailsPage({
    required this.creditCard,
    super.key,
  });
  final CreditCard creditCard;

  @override
  Widget build(BuildContext context) {
    return OBScreen.secondary(
      title: 'Credit Card Details',
      slivers: [
        SliverToBoxAdapter(
          child: CreditCardDetailsWidget(creditCard: creditCard),
        ),
      ].withSpaceBetween(
        height: 16,
        isSliver: true,
      ),
    );
  }
}
