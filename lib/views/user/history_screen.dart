import 'package:barberapp/controllers/booking_controller.dart';
import 'package:barberapp/models/booking_model.dart';
import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/views/user/update_booking_screen.dart';
import 'package:barberapp/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  final UserModel user;
  const HistoryScreen({super.key, required this.user});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final BookingController bookingController = BookingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'History',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.history,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF3E5AB),
      ),
      backgroundColor: const Color(0xFFFFF8DC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: bookingController.getBookingByUserId(widget.user.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading bookings.'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No booking history found.'));
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
                            color: booking.status == 'completed'
                                ? Colors.green[100]
                                : Colors.white,
                            child: ListTile(
                              title: Text("Service: ${booking.service}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date: ${booking.date}"),
                                  Text("Time: ${booking.time}")
                                ],
                              ),
                              trailing: booking.status == 'pending'
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateBooking(
                                                  booking: booking,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Icon(Icons.edit),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              bookingController
                                                  .deleteBooking(booking.id);
                                              showSnackBar(context,
                                                  "Deleted successfully");
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            )),
                                      ],
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
      ),
    );
  }
}
