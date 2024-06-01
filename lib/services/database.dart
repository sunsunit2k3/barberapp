import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfo);
  }

  Future addUserBooking(Map<String, dynamic> bookingInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("bookings")
        .doc(id)
        .set(bookingInfo);
  }
}
