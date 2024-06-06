import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/views/admin/service_manage.dart';
import 'package:barberapp/views/admin/list_booking.dart';
import 'package:barberapp/views/information_screen.dart';
import 'package:flutter/material.dart';

class WrapperAdmin extends StatefulWidget {
  final UserModel user;
  const WrapperAdmin({super.key, required this.user});

  @override
  State<WrapperAdmin> createState() => _WrapperAdminState();
}

class _WrapperAdminState extends State<WrapperAdmin> {
  late List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    widgets = [
      BookingListScreen(user: widget.user),
      ListBooking(),
      InformationScreen(user: widget.user)
    ];
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.design_services_rounded),
              label: 'Manage Services'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_numbered_rtl_rounded),
              label: 'List Booking'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline_rounded), label: 'Information'),
        ],
      ),
    );
  }
}
