import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ob/features/auth/data/auth_repository.dart';
import 'package:ob/features/space/domain/space_model.dart';
import 'package:ob/features/space/domain/space_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _spaceCollection = 'spaces';
const _currentSpaceKey = 'currentSpaceId';

class SpaceRepository {
  SpaceRepository({
    required FirebaseFirestore firestore,
    required SharedPreferences sharedPreferences,
    required AuthRepository authRepository,
  })  : _firestore = firestore,
        _sharedPreferences = sharedPreferences,
        _authRepository = authRepository;

  final FirebaseFirestore _firestore;
  final SharedPreferences _sharedPreferences;
  final AuthRepository _authRepository;

  SpaceModel getCurrentSpace() {
    final space = _sharedPreferences.get(_currentSpaceKey) as String?;
    if (space == null) {
      throw Exception('No current space');
    }

    final json = jsonDecode(space) as Map<String, dynamic>;
    return SpaceModel.fromJson(json);
  }

  Future<void> setCurrentSpace(SpaceModel space) async {
    await _sharedPreferences.setString(
      _currentSpaceKey,
      jsonEncode(space.toJson()),
    );
  }

  Future<List<SpaceModel>> getSpaces() async {
    final userId = _authRepository.user?.uid;

    final spaces = await _firestore
        .collection(_spaceCollection)
        .where('userIds', arrayContains: userId)
        .get();

    return spaces.docs.map((doc) => SpaceModel.fromJson(doc.data())).toList();
  }

  Future<void> createSpace(
    String userId, {
    required String name,
    String? description,
    String? imageUrl,
  }) async {
    final id = _firestore.collection(_spaceCollection).doc().id;

    final space = SpaceModel(
      id: id,
      name: name,
      userIds: [userId],
      description: description,
      imageUrl: imageUrl,
      users: [
        SpaceUserModel(
          role: SpaceUserRole.owner,
          spaceId: id,
          userId: userId,
        ),
      ],
    );

    await _firestore.collection(_spaceCollection).doc(id).set(space.toJson());

    await setCurrentSpace(space);
  }

  Future<void> updateSpace({
    required String spaceId,
    String? name,
    String? description,
    String? imageUrl,
  }) async {
    final sanitizedData = {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };

    if (sanitizedData.isEmpty) return;

    await _firestore
        .collection(_spaceCollection)
        .doc(spaceId)
        .update(sanitizedData);
  }

  Future<void> addUserToSpace(String userId, String spaceId) async {
    final space =
        await _firestore.collection(_spaceCollection).doc(spaceId).get();

    if (!space.exists) return;

    final spaceModel = SpaceModel.fromJson(space.data()!);

    if (spaceModel.userIds.contains(userId)) {
      throw Exception('User already in space');
    }

    spaceModel.userIds.add(userId);

    await _firestore
        .collection(_spaceCollection)
        .doc(spaceId)
        .update(spaceModel.toJson());
  }

  Future<void> deleteSpace(String spaceId) async {
    await _firestore.collection(_spaceCollection).doc(spaceId).delete();
  }
}
