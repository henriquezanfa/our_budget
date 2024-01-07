import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ob/domain/enums/invite_status_enum.dart';
import 'package:ob/domain/enums/permissions_enum.dart';

part 'member.freezed.dart';
part 'member.g.dart';

@freezed
class Member with _$Member {
  factory Member({
    required String email,
    required PermissionsEnum permission,
    required InviteStatusEnum status,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) =>
      _$MemberFromJson(json);
}
