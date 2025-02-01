import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ob/features/currencies_selection/domain/currency.dart';

final _availableCurrencies = <Currency>[
  Currency(
    code: 'BRL',
    emoji: '🇧🇷',
    name: 'real',
  ),
  Currency(
    code: 'EUR',
    emoji: '🇪🇺',
    name: 'euro',
  ),
  Currency(
    code: 'USD',
    emoji: '🇺🇸',
    name: 'dollar',
  ),
];

final defaultCurrency = _availableCurrencies.first;

Currency getCurrencyFromText(String text) {
  return _availableCurrencies.firstWhereOrNull(
        (element) => element.code.toLowerCase() == text.toLowerCase(),
      ) ??
      defaultCurrency;
}

class CurrencySelectorView extends StatefulWidget {
  const CurrencySelectorView({this.onChanged, super.key, this.initial});

  final void Function(Currency currency)? onChanged;
  final Currency? initial;

  @override
  State<CurrencySelectorView> createState() => _CurrencySelectorViewState();
}

class _CurrencySelectorViewState extends State<CurrencySelectorView> {
  late Currency? _selectedCurrency = widget.initial;

  @override
  Widget build(BuildContext context) {
    if (widget.onChanged == null && _selectedCurrency != null) {
      return InputDecorator(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
        child: DropdownMenuItem(
          value: _selectedCurrency,
          enabled: widget.onChanged != null,
          child: Row(
            children: [
              Text(_selectedCurrency!.emoji),
              const SizedBox(width: 8),
              Text(_selectedCurrency!.name.capitalize()),
            ],
          ),
        ),
      );
    }

    return DropdownButtonFormField<Currency>(
      value: _selectedCurrency,
      hint: const Text('Select a currency'),
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value;
          widget.onChanged?.call(_selectedCurrency!);
        });
      },
      items: _availableCurrencies
          .map(
            (e) => DropdownMenuItem(
              value: e,
              enabled: widget.onChanged != null,
              child: Row(
                children: [
                  Text(e.emoji),
                  const SizedBox(width: 8),
                  Text(e.name.capitalize()),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

extension XString on String {
  String capitalize() {
    return substring(0, 1).toUpperCase() + substring(1, length).toLowerCase();
  }
}
