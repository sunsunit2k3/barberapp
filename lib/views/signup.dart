// ignore_for_file: use_build_context_synchronously

import 'package:barberapp/views/login.dart';
import 'package:barberapp/services/database.dart';
import 'package:barberapp/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? name, password, email;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> registration() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );
        String id = randomAlphaNumeric(10);
        Map<String, dynamic> userInfo = {
          "id": id,
          "name": nameController.text,
          "email": emailController.text,
          'role': "User",
          "image":
              "https://png.pngtree.com/thumb_back/fh260/background/20230516/pngtree-cute-wallpapers-cats-wallpapers-hd-4k-wallpapers-desktop-wallpapers-hd-image_2562853.jpg",
        };
        await FirestoreService().setDocument("users", id, userInfo);
        showSnackBar(context, "User Registered Successfully", duration: 3);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          showSnackBar(context, "The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context, "The account already exists for that email.");
        } else if (e.code == 'invalid-email') {
          showSnackBar(context, "The email address is badly formatted.");
        } else {
          showSnackBar(context, "Something went wrong");
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
              "Create your\nAccount !",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 40.0, left: 30.0, right: 30.0, bottom: 20.0),
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
                      "Name",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFB81635)),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: "Enter your name",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.account_box_rounded)),
                    ),
                    const SizedBox(height: 20.0),
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
                          hintText: "Enter your Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.password_outlined)),
                      obscureText: true,
                    ),
                    const SizedBox(height: 80.0),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            name = nameController.text;
                            email = emailController.text;
                            password = passwordController.text;
                          });
                          registration();
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
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Already have an account?",
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
                                builder: (context) => const Login()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                                color: Color(0xFFB81635),
                                fontSize: 28.0,
                                fontWeight: FontWeight.w500),
                          ),
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
          )
        ],
      ),
    );
  }
}
