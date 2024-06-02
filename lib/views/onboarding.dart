import 'package:barberapp/views/login.dart';
import 'package:flutter/material.dart';

class OnBorading extends StatelessWidget {
  const OnBorading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: Container(
          margin: const EdgeInsets.only(top: 120.0),
          child: Column(
            children: [
              const Image(
                image: AssetImage("assets/images/barber.png"),
              ),
              const SizedBox(height: 100),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFdf711a),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text("Get a Stylish Haircut",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              )
            ],
          )),
    );
  }
}
