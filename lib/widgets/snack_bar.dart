import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, {int duration = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 20.0),
      ),
      duration: Duration(seconds: duration),
    ),
  );
}
