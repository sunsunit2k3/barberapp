import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/views/user/history_screen.dart';
import 'package:barberapp/views/user/home_view.dart';
import 'package:barberapp/views/information_screen.dart';
import 'package:flutter/material.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline_rounded), label: 'Information'),
        ],
      ),
    );
  }
}
