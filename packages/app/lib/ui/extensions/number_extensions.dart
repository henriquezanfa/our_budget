extension FormatCurrency on double {
  String get currency => '\$${toStringAsFixed(2)}';
}
