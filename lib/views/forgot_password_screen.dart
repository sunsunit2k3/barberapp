// ignore_for_file: use_build_context_synchronously

import 'package:barberapp/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isLoading = false;
  String? email;

  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  resetPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      showSnackBar(context, "Email sent");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "No user found for that email.");
      } else {
        showSnackBar(context, "Error");
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3E5AB),
        title: const Text("Forgot Password",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w400)),
      ),
      backgroundColor: const Color(0xFFFFF8DC),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Enter your email to reset your password",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white70, width: 2.0),
              ),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Your Email",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 22),
                    prefixIcon: Icon(Icons.email)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  email = emailController.text;
                });
                resetPassword();
              }
            },
            child: Container(
                width: 160,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0XFFe29452),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          "Send Email",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w500),
                        ),
                )),
          )
        ]),
      ),
    );
  }
}
