import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ob/domain/domain.dart';

part 'credit_card.freezed.dart';
part 'credit_card.g.dart';

@freezed
class CreditCard with _$CreditCard {
  factory CreditCard({
    required String id,
    required String userId,
    required String name,
    required String currency,
    required String accountHolderName,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime dueDate,
    List<Member>? members,
  }) = _CreditCard;

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);
}
