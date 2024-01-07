import 'package:flutter/material.dart';

class OBCurrencyPicker extends StatelessWidget {
  const OBCurrencyPicker({
    required this.onChanged,
    super.key,
    this.initialCurrency,
  });
  final OBCurrency? initialCurrency;
  final ValueChanged<OBCurrency?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<OBCurrency>(
      value: initialCurrency,
      onChanged: onChanged,
      items: OBCurrency.values
          .map(
            (e) => DropdownMenuItem<OBCurrency>(
              value: e,
              child: Row(
                children: [
                  Text('${e.code} - ${e.symbol}'),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

enum OBCurrency {
  eur('EUR', '€'),
  usd('USD', r'$'),
  brl('BRL', r'R$');

  const OBCurrency(this.code, this.symbol);

  final String code;
  final String symbol;
}
