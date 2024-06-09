// ignore_for_file: use_build_context_synchronously

import 'package:barberapp/controllers/booking_controller.dart';
import 'package:barberapp/controllers/service_controller.dart';
import 'package:barberapp/models/booking_model.dart';
import 'package:barberapp/models/services.dart';
import 'package:barberapp/ultils/date_time_utils.dart';
import 'package:barberapp/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class UpdateBooking extends StatefulWidget {
  final BookingModel booking;
  const UpdateBooking({super.key, required this.booking});

  @override
  State<UpdateBooking> createState() => _UpdateBookingState();
}

class _UpdateBookingState extends State<UpdateBooking> {
  late String dropDownValue;
  late Stream<List<ServiceModel>> _servicesStream;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _servicesStream = ServiceController().getServicesStream();
    dropDownValue = widget.booking.service;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF3E5AB),
        appBar: AppBar(
          title: const Text("Update Booking",
              style: TextStyle(
                color: Colors.black,
              )),
          backgroundColor: Theme.of(context).highlightColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
          child: Column(
            children: [
              StreamBuilder<List<ServiceModel>>(
                stream: _servicesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 247, 241, 241),
                        borderRadius: BorderRadius.circular(20.0)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const Text(
                          "Set a Service",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 23.0,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10.0),
                        DropdownButton(
                          value: dropDownValue,
                          items: [
                            for (var service in snapshot.data!)
                              DropdownMenuItem<String>(
                                  // ignore: sort_child_properties_last
                                  child: Text(service.name),
                                  value: service.name)
                          ],
                          onChanged: dropdownCallback,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 28),
                          iconEnabledColor: Colors.black,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 241, 241),
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
                          onTap: () => DateTimeUtils.selectDate(
                              context, _selectedDate, (DateTime picked) {
                            setState(() {
                              _selectedDate = picked;
                            });
                          }),
                          child: const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                            size: 40.0,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                          "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                          style: const TextStyle(
                              color: Colors.black,
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
                    color: const Color.fromARGB(255, 247, 241, 241),
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
                          onTap: () => DateTimeUtils.selectTime(
                              context, _selectedTime, (TimeOfDay picked) {
                            setState(() {
                              _selectedTime = picked;
                            });
                          }),
                          child: const Icon(
                            Icons.alarm,
                            color: Colors.black,
                            size: 40.0,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                          _selectedTime.format(context),
                          style: const TextStyle(
                              color: Colors.black,
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
                  Map<String, dynamic> booking = {
                    'serivce': dropDownValue,
                    'date':
                        " ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                    'time': _selectedTime.format(context).toString(),
                  };
                  await BookingController()
                      .updateBooking(booking, widget.booking.id);
                  showSnackBar(context, "Booking Updated Successfully");
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFdf711a),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text("UPDATE NOW",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void dropdownCallback(String? value) {
    if (value is String) {
      setState(() {
        dropDownValue = value;
      });
    }
  }
}
