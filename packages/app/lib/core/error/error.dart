class OBError extends Error {
  OBError({
    required this.userMessage,
    required this.message,
  });

  final String userMessage;
  final String message;
}

class ErrorMessages {
  static const String somethingWentWrong = 'Something went wrong';
  static const String couldNotCreateTransaction =
      'Could not create transaction';

  static const String couldNotGetTransactions = 'Could not get transactions';
}
