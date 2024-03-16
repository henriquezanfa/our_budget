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

  String? get currentSpaceId => _sharedPreferences.getString(_currentSpaceKey);

  Future<void> setCurrentSpace(String id) async {
    await _sharedPreferences.setString(_currentSpaceKey, id);
  }

  Future<SpaceModel> getCurrentSpace() async {
    final spaceId = currentSpaceId;

    final space =
        await _firestore.collection(OBCollections.space).doc(spaceId).get();

    final data = space.data();
    if (data == null) {
      throw Exception('Space not found');
    }

    return SpaceModel.fromJson(space.data()!);
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

    await setCurrentSpace(space.id);
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
  }

  Future<SpaceModel> changeSpace(String spaceId) async {
    await setCurrentSpace(spaceId);
    return getCurrentSpace();
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
  }

  Future<void> deleteSpace(String spaceId) async {
    await _firestore.collection(OBCollections.space).doc(spaceId).delete();
  }

  Future<List<SpaceModel>> getInvitedSpaces(String email) async {
    final spaces = await _firestore
        .collection(OBCollections.space)
        .where('invitedEmails', arrayContains: email)
        .get();

    return spaces.docs.map((doc) => SpaceModel.fromJson(doc.data())).toList();
  }

  Future<void> replyToInvitation({
    required String spaceId,
    required bool accept,
  }) async {
    final userId = _authRepository.user!.uid;
    final space =
        await _firestore.collection(OBCollections.space).doc(spaceId).get();

    if (!space.exists) return;
    final spaceModel = SpaceModel.fromJson(space.data()!);

    if (spaceModel.userIds.contains(userId)) {
      throw Exception('User already in space');
    }

    if (accept) {
      final newUsers = [
        ...spaceModel.users,
        SpaceUserModel(
          name: _authRepository.user!.displayName ?? '',
          role: SpaceUserRole.member,
          spaceId: spaceId,
          userId: userId,
          status: SpaceUserStatus.active,
        ),
      ];
      final newEmails = [
        ...spaceModel.invitedEmails ?? <String>[],
      ]..remove(_authRepository.user!.email);
      final newIds = [
        ...spaceModel.userIds,
        userId,
      ];
      final newSpace = spaceModel.copyWith(
        users: newUsers,
        invitedEmails: newEmails,
        userIds: newIds,
      );

      await _firestore
          .collection(OBCollections.space)
          .doc(spaceId)
          .update(newSpace.toJson());
    } else {
      final newEmails = [
        ...spaceModel.invitedEmails ?? <String>[],
      ]..remove(_authRepository.user!.email);
      final newSpace = spaceModel.copyWith(invitedEmails: newEmails);

      await _firestore
          .collection(OBCollections.space)
          .doc(spaceId)
          .update(newSpace.toJson());
    }
  }
}
