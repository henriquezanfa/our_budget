import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ob/domain/models/transaction_category/transaction_category.dart';

class CategoriesDataSource {
  CategoriesDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<TransactionCategory>> getCategories() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final query = _firestore.collection('categories').where(
          'userId',
          isEqualTo: userId,
        );

    final data = await query.get();

    return data.docs.map((doc) {
      final data = doc.data();

      return TransactionCategory.fromJson(data);
    }).toList();
  }

  Future<void> addCategory(TransactionCategory category) async {
    final doc = _firestore.collection('categories').doc();

    await doc.set(category.toJson());
  }

  Future<void> updateCategory(TransactionCategory category) async {
    final doc = _firestore.collection('categories').doc(category.id);

    await doc.update(category.toJson());
  }
}
