// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String id;
  String name;
  String image_url;
  String description;
  ServiceModel({
    required this.id,
    required this.name,
    required this.image_url,
    required this.description,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> doc) {
    return ServiceModel(
      id: doc['id'],
      image_url: doc['image_url'],
      name: doc['name'],
      description: doc['description'],
    );
  }
  factory ServiceModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ServiceModel(
      id: doc.id,
      name: data['name'] ?? '',
      image_url: data['image_url'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
