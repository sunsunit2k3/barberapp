import 'package:barberapp/models/booking_model.dart';
import 'package:barberapp/services/database.dart';
import 'package:random_string/random_string.dart';

class BookingController {
  Future<void> addBooking(BookingModel booking) async {
    String id = randomAlphaNumeric(10);
    await DatabaseMethods().addBooking(booking.toMap(), id);
  }
}
