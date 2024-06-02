// booking_model.dart
import 'package:barberapp/models/user_model.dart';
import 'package:flutter/material.dart';

class BookingModel {
  String service;
  DateTime date;
  TimeOfDay time;
  UserModel user;

  BookingModel({
    required this.service,
    required this.date,
    required this.time,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      "service": service,
      "date": "${date.day}/${date.month}/${date.year}",
      "time":
          "${time.hour}:${time.minute} ${time.period == DayPeriod.am ? 'AM' : 'PM'}",
      "name": user.name,
      "email": user.email,
    };
  }
}
