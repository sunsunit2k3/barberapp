import 'package:barberapp/models/user_model.dart';
import 'package:flutter/material.dart';

class BookingListScreen extends StatefulWidget {
  UserModel user;

  BookingListScreen({super.key, required this.user});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
