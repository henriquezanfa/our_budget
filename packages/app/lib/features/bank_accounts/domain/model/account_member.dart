import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_invite_status_enum.dart';
import 'package:ob/features/bank_accounts/domain/enum/account_permissions_enum.dart';

part 'account_member.freezed.dart';
part 'account_member.g.dart';

@freezed
class AccountMember with _$AccountMember {
  factory AccountMember({
    required String email,
    required AccountPermissionsEnum permission,
    required AccountInviteStatusEnum status,
  }) = _AccountMemberRole;

  factory AccountMember.fromJson(Map<String, dynamic> json) =>
      _$AccountMemberFromJson(json);
}
