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

  Future<void> deleteOutdatedPendingBookings() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('status', isEqualTo: 'pending')
        .get();

    DateTime now = DateTime.now();
    DateTime nowHourMinute =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    for (var doc in snapshot.docs) {
      BookingModel booking =
          BookingModel.fromMap(doc.data() as Map<String, dynamic>);

      String bookingTime24Hour = convertTimeFormat(booking.time);
      String bookingDateTimeString = '${booking.date} $bookingTime24Hour';
      DateFormat inputDateFormat = DateFormat(
          'M/d/yyyy HH:mm'); // Adjust this to your actual date format if needed
      DateTime bookingDateTime = inputDateFormat.parse(bookingDateTimeString);
      if (bookingDateTime.compareTo(nowHourMinute) > 0) {
        await deleteBooking(doc.id);
        // print("OK");
      }
    }
  }

  String convertTimeFormat(String time) {
    DateFormat inputFormat = DateFormat('h:mm a');
    DateFormat outputFormat = DateFormat('HH:mm');
    DateTime dateTime = inputFormat.parse(time);
    return outputFormat.format(dateTime);
  }
}
