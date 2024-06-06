import 'package:barberapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingController {
  Future<void> addBooking(Map<String, dynamic> booking, id) async {
    await FirestoreService().setDocument("bookings", id, booking);
  }

  Stream<QuerySnapshot> getBookingDetails() {
    return FirebaseFirestore.instance.collection('bookings').snapshots();
  }

  Future<void> updateBooking(
      String serviceName, String date, String time, String id) async {
    Map<String, dynamic> bookingInfo = {
      'service': serviceName,
      'date': date,
      'time': time,
    };
    await FirestoreService().updateDocument("bookings", id, bookingInfo);
  }

  Future<void> deleteBooking(String id) async {
    await FirestoreService().deleteDocument("bookings", id);
  }

  Stream<QuerySnapshot> getBookingByUserId(String id) {
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('user_id', isEqualTo: id)
        .snapshots();
  }
}
