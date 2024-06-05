import 'package:barberapp/models/user_model.dart';
import 'package:flutter/material.dart';

class ServicesManageScreen extends StatefulWidget {
  UserModel user;

  ServicesManageScreen({super.key, required this.user});

  @override
  State<ServicesManageScreen> createState() => _ServicesManageScreenState();
}

class _ServicesManageScreenState extends State<ServicesManageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
