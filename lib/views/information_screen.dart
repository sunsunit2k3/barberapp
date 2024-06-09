// ignore_for_file: use_build_context_synchronously

import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/views/login.dart';
import 'package:barberapp/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  final UserModel user;
  const InformationScreen({super.key, required this.user});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    showSnackBar(context, "Log Out Successfully", duration: 2);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: 30,
            )
          ],
        ),
        backgroundColor: const Color(0xFFF3E5AB),
      ),
      backgroundColor: const Color(0xFFFFF8DC),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.user.image),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.user.name,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              widget.user.email,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFe29452),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
