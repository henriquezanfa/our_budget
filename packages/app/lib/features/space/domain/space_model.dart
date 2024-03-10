import 'package:ob/features/space/domain/space_user_model.dart';

class SpaceModel {
  SpaceModel({
    required this.id,
    required this.name,
    required this.users,
    required this.userIds,
    this.description,
    this.imageUrl,
  });

  factory SpaceModel.fromJson(Map<String, dynamic> json) {
    return SpaceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      users: (json['users'] as List<dynamic>)
          .map((user) => SpaceUserModel.fromJson(user as Map<String, dynamic>))
          .toList(),
      userIds: (json['userIds'] as List<dynamic>)
          .map((user) => user as String)
          .toList(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  final String id;
  final String name;
  final List<SpaceUserModel> users;
  final List<String> userIds;
  final String? description;
  final String? imageUrl;

  SpaceModel copyWith({
    String? id,
    String? name,
    List<SpaceUserModel>? users,
    List<String>? userIds,
    String? description,
    String? imageUrl,
  }) {
    return SpaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      users: users ?? this.users,
      userIds: userIds ?? this.userIds,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'users': users.map((e) => e.toJson()).toList(),
      'userIds': userIds,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}