import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ob/core/client/constants.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';
import 'package:ob/features/space/core.dart';

class CategoriesDataSource {
  CategoriesDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<TransactionCategory>> getCategories({
    required SpaceId spaceId,
    required String userId,
  }) async {
    final query = _firestore
        .collection(OBCollections.space)
        .doc(spaceId)
        .collection('categories');

    final data = await query.get();

    return data.docs.map((doc) {
      final data = doc.data();

      return TransactionCategory.fromJson(data);
    }).toList();
  }

  Future<void> addCategory({
    required SpaceId spaceId,
    required TransactionCategory category,
  }) async {
    final doc = _firestore
        .collection(OBCollections.space)
        .doc(spaceId)
        .collection('categories')
        .doc();

    await doc.set(category.toJson());
  }

  Future<void> updateCategory({
    required SpaceId spaceId,
    required TransactionCategory category,
  }) async {
    final doc = _firestore
        .collection(OBCollections.space)
        .doc(spaceId)
        .collection('categories')
        .doc(category.id);

    await doc.update(category.toJson());
  }
}
