import 'package:barberapp/models/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceController {
  Stream<List<ServiceModel>> getServicesStream() {
    return FirebaseFirestore.instance.collection('services').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ServiceModel.fromDocument(doc))
            .toList());
  }
}
