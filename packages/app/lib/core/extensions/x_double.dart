extension XDouble on double {
  String toCurrency() {
    return '\$${toStringAsFixed(2)}';
  }
}
