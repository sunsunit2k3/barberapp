import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/views/user/history_screen.dart';
import 'package:barberapp/views/user/home_screen.dart';
import 'package:barberapp/views/information_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Wrapper extends StatefulWidget {
  final UserModel user;
  const Wrapper({super.key, required this.user});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    widgets = [
      Home(user: widget.user),
      HistoryScreen(
        user: widget.user,
      ),
      InformationScreen(user: widget.user)
    ];
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.elementAt(index),
      bottomNavigationBar: GNav(
        backgroundColor: const Color(0xFFF3E5AB),
        tabBackgroundColor: const Color(0xFFFFF8DC),
        gap: 8,
        onTabChange: (i) {
          setState(() {
            index = i;
          });
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.history,
            text: 'History',
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
