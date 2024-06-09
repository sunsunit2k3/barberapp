import 'package:barberapp/controllers/booking_controller.dart';
import 'package:barberapp/controllers/user_controller.dart';
import 'package:barberapp/models/booking_model.dart';
import 'package:barberapp/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListBooking extends StatefulWidget {
  const ListBooking({super.key});

  @override
  State<ListBooking> createState() => _ListBookingState();
}

class _ListBookingState extends State<ListBooking> {
  final BookingController bookingController = BookingController();
  final UserController userController = UserController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'List Booking',
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w400),
          ),
        ),
        backgroundColor: const Color(0xFFF3E5AB),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: bookingController.getBookingDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No booking history found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var bookingData = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      var booking = BookingModel.fromMap(bookingData);
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Card(
                          child: ListTile(
                            title: Text(booking.service),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Date: ${booking.date}"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Time: ${booking.time}"),
                                Text("Name: ${booking.user_name}"),
                              ],
                            ),
                            trailing: booking.status == 'pending'
                                ? GestureDetector(
                                    onTap: () {
                                      bookingController.updateBooking(
                                        {"status": "completed"},
                                        snapshot.data!.docs[index].id,
                                      );
                                      showSnackBar(
                                          context, "Completed successfully");
                                    },
                                    child: const Text("Click to complete"),
                                  )
                                : GestureDetector(
                                    child: const Text("Completed"),
                                  ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
