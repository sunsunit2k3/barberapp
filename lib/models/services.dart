// service_model.dart
class ServiceModel {
  String name;
  String image_url;

  ServiceModel({
    required this.name,
    required this.image_url,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> doc) {
    return ServiceModel(
      image_url: doc['image_url'],
      name: doc['name'],
    );
  }
}
