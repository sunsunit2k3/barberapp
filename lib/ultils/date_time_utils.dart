import 'package:flutter/material.dart';

class DateTimeUtils {
  static Future<void> selectDate(BuildContext context, DateTime selectedDate,
      Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }
  }

  static Future<void> selectTime(BuildContext context, TimeOfDay selectedTime,
      Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      onTimeSelected(picked);
    }
  }
}
