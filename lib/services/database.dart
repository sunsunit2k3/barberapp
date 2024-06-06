import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setDocument(
      String collection, String id, Map<String, dynamic> data) async {
    return await _firestore.collection(collection).doc(id).set(data);
  }

  Future<void> deleteDocument(String collection, String id) async {
    return await _firestore.collection(collection).doc(id).delete();
  }

  Future<void> updateDocument(
      String collection, String id, Map<String, dynamic> data) async {
    return await _firestore.collection(collection).doc(id).update(data);
  }
}
