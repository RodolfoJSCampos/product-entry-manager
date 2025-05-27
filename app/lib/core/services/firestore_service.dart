import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collectionPath).doc(docId).set(data);
  }

  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collectionPath).doc(docId).update(data);
  }

  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
  }) async {
    await _firestore.collection(collectionPath).doc(docId).delete();
  }

  Future<Map<String, dynamic>?> getDocument({
    required String collectionPath,
    required String docId,
  }) async {
    final doc = await _firestore.collection(collectionPath).doc(docId).get();
    return doc.exists ? doc.data() : null;
  }

  Future<List<Map<String, dynamic>>> getCollection({
    required String collectionPath,
    Query Function(Query)? queryBuilder,
  }) async {
    Query query = _firestore.collection(collectionPath);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
