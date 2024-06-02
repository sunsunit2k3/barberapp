// ignore_for_file: use_build_context_synchronously

import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/views/signup.dart';
import 'package:barberapp/views/wrapper.dart';
import 'package:barberapp/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? password, email;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> userLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userData = userDoc.data() as Map<String, dynamic>;
        UserModel user = UserModel(
          id: userData['id'],
          name: userData['name'],
          email: userData['email'],
          image: userData['image'],
        );

        // Show success message
        showSnackBar(context, "User Login Successfully", duration: 2);

        // Navigate to Home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(
              user: user,
            ),
          ),
        );
      } else {
        showSnackBar(context, "User data not found.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showSnackBar(context, "No user found for that email.");
      } else if (e.code == 'invalid-credential') {
        showSnackBar(context, "Wrong password provided for that user.");
      } else {
        showSnackBar(context, "Something went wrong");
        // print(e.code);
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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 50.0, left: 20.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFB81635),
                  Color(0xff621d3c),
                  Color(0xff311937),
                ],
              ),
              color: Color(0xFF2b1615),
            ),
            child: const Text(
              "Hello\nSign In!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gmail",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFB81635)),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: "Enter your email",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFB81635)),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: const InputDecoration(
                          hintText: "Enter your password",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.password_outlined)),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff311937)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80.0),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          email = emailController.text;
                          password = passwordController.text;
                          userLogin();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFB81635),
                              Color(0xff621d3c),
                              Color(0xff311937),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account?",
                          style:
                              TextStyle(color: Color(0xff621d3c), fontSize: 20),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Sign Up",
                              style: TextStyle(
                                  color: Color(0xFFB81635),
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    const SizedBox(
                        height:
                            20.0), // Add some bottom padding for better spacing
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
