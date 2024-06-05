// ignore_for_file: non_constant_identifier_names

class BookingModel {
  final String user_id; // Add this line
  final String id;
  final String service;
  final String date;
  final String time;
  final String status;

  BookingModel({
    required this.id,
    required this.user_id,
    required this.service,
    required this.date,
    required this.time,
    required this.status,
  });

  factory BookingModel.fromMap(Map<String, dynamic> data) {
    return BookingModel(
      user_id: data['user_id'] ?? '',
      id: data['id'] ?? '',
      service: data['service'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      status: data['status'] ?? '',
    );
  }
}
