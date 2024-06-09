import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/views/admin/manage_image_screen.dart';
import 'package:barberapp/views/admin/manage_services.dart';
import 'package:barberapp/views/admin/list_booking.dart';
import 'package:barberapp/views/information_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class WrapperAdmin extends StatefulWidget {
  final UserModel user;
  const WrapperAdmin({super.key, required this.user});

  @override
  State<WrapperAdmin> createState() => _WrapperAdminState();
}

class _WrapperAdminState extends State<WrapperAdmin> {
  late List<Widget> widgets;
  int index = 0;

  @override
  void initState() {
    super.initState();
    widgets = [
      BookingListScreen(
          user: widget.user), // Update this with the correct screen
      const ListBooking(),
      const ManageImageScreen(),
      InformationScreen(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[index],
      bottomNavigationBar: GNav(
        onTabChange: (i) {
          setState(() {
            index = i;
          });
        },
        backgroundColor: const Color(0xFFF3E5AB),
        tabBackgroundColor: const Color(0xFFFFF8DC),
        gap: 8,
        tabs: const [
          GButton(
            icon: Icons.design_services_rounded,
            text: 'Services',
          ),
          GButton(
            icon: Icons.list_alt,
            text: 'Booking List',
          ),
          GButton(
            icon: Icons.image,
            text: 'Pictures',
          ),
          GButton(
            icon: Icons.info,
            text: 'Information',
          ),
        ],
      ),
    );
  }
}
