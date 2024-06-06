// ignore_for_file: non_constant_identifier_names
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
}
