import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ob/core/client/constants.dart';
import 'package:ob/features/auth/data/auth_repository.dart';
import 'package:ob/features/space/domain/space_model.dart';
import 'package:ob/features/space/domain/space_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  SpaceModel? _currentSpace;
  SpaceModel get currentSpace {
    if (_currentSpace == null) {
      final space = _sharedPreferences.getString(_currentSpaceKey);
      if (space != null) {
        _currentSpace = SpaceModel.fromJson(
          jsonDecode(space) as Map<String, dynamic>,
        );
      }

      if (_currentSpace == null) {
        throw Exception('No current space');
      }
    }
    return _currentSpace!;
  }

  String get currentSpaceId {
    if (_currentSpace == null) {
      throw Exception('No current space');
    }
    return _currentSpace!.id;
  }

  Future<SpaceModel> getCurrentSpace() async {
    final spaceId = currentSpaceId;

    final space =
        await _firestore.collection(OBCollections.space).doc(spaceId).get();

    if (!space.exists) {
      throw Exception('No current space');
    }

    final model = SpaceModel.fromJson(space.data()!);
    _currentSpace = model;

    return model;
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
        .collection(OBCollections.space)
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
    final id = _firestore.collection(OBCollections.space).doc().id;

    final space = SpaceModel(
      id: id,
      name: name,
      userIds: [userId],
      description: description,
      imageUrl: imageUrl,
      users: [
        SpaceUserModel(
          name: _authRepository.user?.displayName ?? '',
          role: SpaceUserRole.owner,
          spaceId: id,
          userId: userId,
        ),
      ],
    );

    await _firestore
        .collection(OBCollections.space)
        .doc(id)
        .set(space.toJson());

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
        .collection(OBCollections.space)
        .doc(spaceId)
        .update(sanitizedData);

    await setCurrentSpace(
      currentSpace.copyWith(
        name: name,
        description: description,
        imageUrl: imageUrl,
      ),
    );
  }

  Future<void> inviteUserToSpace(String email) async {
    final spaceId = currentSpaceId;
    final space =
        await _firestore.collection(OBCollections.space).doc(spaceId).get();

    if (!space.exists) return;
    final spaceModel = SpaceModel.fromJson(space.data()!);

    if (spaceModel.invitedEmails?.contains(email) ?? false) {
      throw Exception('User already invited');
    }

    final newEmails = [...spaceModel.invitedEmails ?? <String>[], email];
    final newSpace = spaceModel.copyWith(invitedEmails: newEmails);

    await _firestore
        .collection(OBCollections.space)
        .doc(spaceId)
        .update(newSpace.toJson());

    _currentSpace = newSpace;
  }

  Future<void> deleteSpace(String spaceId) async {
    await _firestore.collection(OBCollections.space).doc(spaceId).delete();
  }
}
