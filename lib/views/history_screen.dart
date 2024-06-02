import 'package:barberapp/models/user_model.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  UserModel user;
  HistoryScreen({super.key, required this.user});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
