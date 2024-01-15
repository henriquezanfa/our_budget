import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesDataSource {
  CategoriesDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<String>> getCategories() async {
    final query = _firestore.collection('categories');

    final data = await query.get();

    final categories = data.docs.map((doc) => doc.data()['name'] as String);

    return categories.toList();
  }

  Future<void> addCategory(String category) async {
    final doc = _firestore.collection('categories').doc();

    await doc.set({'name': category});
  }
}
