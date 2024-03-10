import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_card.freezed.dart';
part 'credit_card.g.dart';

@freezed
class CreditCard with _$CreditCard {
  factory CreditCard({
    required String id,
    required String userId,
    required String description,
    required String currency,
    required double limit,
    required int dueDate,
    required int closingDate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CreditCard;

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);
}
