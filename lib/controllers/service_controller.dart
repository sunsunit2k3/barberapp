import 'package:barberapp/models/services.dart';
import 'package:barberapp/services/database.dart';
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

  Future<void> addService(Map<String, dynamic> service, id) async {
    await FirestoreService().setDocument("services", id, service);
  }

  Future<void> updateService(
      Map<String, dynamic> serviceInfo, String id) async {
    await FirestoreService().updateDocument("services", id, serviceInfo);
  }

  Future<void> deleteService(String id) async {
    await FirestoreService().deleteDocument("services", id);
  }
}
