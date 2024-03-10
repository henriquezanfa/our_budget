class SpaceUserModel {
  SpaceUserModel({
    required this.userId,
    required this.spaceId,
    required this.role,
    this.status = SpaceUserStatus.pending,
  });

  factory SpaceUserModel.fromJson(Map<String, dynamic> json) {
    return SpaceUserModel(
      userId: json['userId'] as String,
      spaceId: json['spaceId'] as String,
      role: SpaceUserRole.values.firstWhere(
        (role) => role.toString() == json['role'] as String,
      ),
      status: SpaceUserStatus.values.firstWhere(
        (status) => status.toString() == json['status'] as String,
        orElse: () => SpaceUserStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'spaceId': spaceId,
      'role': role.toString(),
      'status': status.toString(),
    };
  }

  final String userId;
  final String spaceId;
  final SpaceUserRole role;
  final SpaceUserStatus status;
}

enum SpaceUserRole {
  owner,
  admin,
  member,
}

enum SpaceUserStatus {
  active,
  inactive,
  pending,
}
