import 'package:barberapp/models/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceController {
  Stream<List<ServiceModel>> getServicesStream() {
    return FirebaseFirestore.instance.collection('services').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return ServiceModel.fromMap(doc.data());
        }).toList();
      },
    );
  }
}
