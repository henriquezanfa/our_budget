import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/features/credit_cards/data/dto/credit_card_creation_dto.dart';
import 'package:ob/features/credit_cards/presentations/bloc/credit_card_bloc.dart';
import 'package:ob/features/credit_cards/presentations/ui/modal/create_credit_card_modal.dart';
import 'package:ob/ui/widgets/widgets.dart';

class CreateCreditCard extends StatelessWidget {
  factory CreateCreditCard.button() => const CreateCreditCard._(isIcon: false);

  factory CreateCreditCard.icon() => const CreateCreditCard._(isIcon: true);
  const CreateCreditCard._({required bool isIcon}) : _isIcon = isIcon;

  final bool _isIcon;

  Future<void> _createCreditCard(BuildContext context) async {
    final creditCardCreationDto =
        await showCreateCreditCardModal<CreditCardCreationDto>(
      context: context,
    );

    if (creditCardCreationDto != null) {
      if (!context.mounted) return;
      BlocProvider.of<CreditCardBloc>(context).add(
        CreateCreditCardEvent(creditCardCreationDto),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isIcon) {
      return IconButton(
        onPressed: () => _createCreditCard(context),
        icon: const Icon(Icons.add_circle_outline),
      );
    }

    return OBElevatedButton(
      onPressed: () => _createCreditCard(context),
      text: 'Create Credit Card',
    );
  }
}
