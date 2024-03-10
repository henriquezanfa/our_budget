import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ob/features/credit_cards/data/dto/credit_card_creation_dto.dart';
import 'package:ob/features/credit_cards/presentations/bloc/credit_card_bloc.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

// ignore: comment_references
/// Don't use this method directly, use [CreateCreditCard] instead.
Future<CreditCardCreationDto?>
    showCreateCreditCardModal<CreditCardCreationDto>({
  required BuildContext context,
}) {
  return Navigator.of(context, rootNavigator: true).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<CreditCardBloc>(context),
        child: const _CreateCreditCardModal(),
      ),
    ),
  );
}

class _CreateCreditCardModal extends StatefulWidget {
  const _CreateCreditCardModal();

  @override
  State<_CreateCreditCardModal> createState() => _CreateCreditCardModalState();
}

class _CreateCreditCardModalState extends State<_CreateCreditCardModal> {
  late final TextEditingController _descriptionController;
  late final TextEditingController _dueDateController;
  late final TextEditingController _closingDateController;
  late final TextEditingController _limitController;
  OBCurrency _currency = OBCurrency.brl;

  bool get _isFormValid =>
      _descriptionController.text.isNotEmpty &&
      _dueDateController.text.isNotEmpty &&
      _closingDateController.text.isNotEmpty &&
      _limitController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _descriptionController = TextEditingController();
    _dueDateController = TextEditingController();
    _closingDateController = TextEditingController();
    _limitController = TextEditingController();

    _descriptionController.addListener(() => setState(() {}));
    _dueDateController.addListener(() => setState(() {}));
    _closingDateController.addListener(() => setState(() {}));
    _limitController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _dueDateController.dispose();
    _closingDateController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OBScreen.secondary(
      title: 'Create credit card',
      bottomWidget: BlocBuilder<CreditCardBloc, CreditCardState>(
        builder: (context, state) {
          return OBElevatedButton(
            isLoading: state is CreditCardLoading,
            onPressed: _isFormValid
                ? () {
                    Navigator.of(context).pop(
                      CreditCardCreationDto(
                        name: _descriptionController.text,
                        currency: _currency.code,
                        limit: double.parse(_limitController.text),
                        closingDate: int.parse(_closingDateController.text),
                        dueDate: int.parse(_dueDateController.text),
                      ),
                    );
                  }
                : null,
            text: 'Create',
          );
        },
      ),
      children: [
        SliverToBoxAdapter(
          child: TextFormField(
            controller: _limitController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              hintText: 'Limit',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: OBCurrencyPicker(
            initialCurrency: _currency,
            onChanged: (currency) {
              if (currency == null) return;
              setState(() {
                _currency = currency;
              });
            },
          ),
        ),
        SliverToBoxAdapter(
          child: TextFormField(
            controller: _closingDateController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              hintText: 'Closing date',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: TextFormField(
            controller: _dueDateController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              hintText: 'Due date',
            ),
          ),
        ),
      ].withSpaceBetween(height: 16, isSliver: true),
    );
  }
}
