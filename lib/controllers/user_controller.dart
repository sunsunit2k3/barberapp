import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  Stream<QuerySnapshot> getUserId(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .snapshots();
  }
}
