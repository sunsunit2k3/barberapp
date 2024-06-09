import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  Stream<QuerySnapshot> getUser() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }
}
