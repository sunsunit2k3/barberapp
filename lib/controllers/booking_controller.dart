import 'package:barberapp/models/booking_model.dart';
import 'package:barberapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingController {
  Future<void> addBooking(Map<String, dynamic> booking, id) async {
    await FirestoreService().setDocument("bookings", id, booking);
  }

  Stream<QuerySnapshot> getBookingDetails() {
    return FirebaseFirestore.instance.collection('bookings').snapshots();
  }

  Future<void> updateBooking(
      Map<String, dynamic> bookingData, String id) async {
    await FirestoreService().updateDocument("bookings", id, bookingData);
  }

  Future<void> deleteBooking(String id) async {
    await FirestoreService().deleteDocument("bookings", id);
  }

  Stream<QuerySnapshot> getBookingByUserId(String id) {
    try {
      return FirebaseFirestore.instance
          .collection('bookings')
          .where('user_id', isEqualTo: id)
          .snapshots();
    } catch (e) {
      return const Stream.empty();
    }
  }
}
