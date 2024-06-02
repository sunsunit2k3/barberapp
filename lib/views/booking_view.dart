// booking_view.dart
import 'dart:async';

import 'package:barberapp/controllers/booking_controller.dart';
import 'package:barberapp/models/booking_model.dart';
import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  String service;
  UserModel user;
  Booking({
    super.key,
    required this.service,
    required this.user,
  });

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Let's the\njouney begin",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Image(
                image: AssetImage("assets/images/discount.png"),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: Text(
                widget.service,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20.0),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                      color: const Color(0xFFb4817e),
                      borderRadius: BorderRadius.circular(20.0)),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const Text(
                        "Set a Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 23.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Text(
                            "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                      color: const Color(0xFFb4817e),
                      borderRadius: BorderRadius.circular(20.0)),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const Text(
                        "Set a Time",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 23.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => _selectTime(context),
                            child: const Icon(
                              Icons.alarm,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Text(
                            _selectedTime.format(context),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () async {
                    BookingModel booking = BookingModel(
                      service: widget.service,
                      date: _selectedDate,
                      time: _selectedTime,
                      user: widget.user,
                    );
                    await BookingController().addBooking(booking).then((value) {
                      showSnackBar(context, "Booking Successful", duration: 3);
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFdf711a),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text("BOOK NOW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
