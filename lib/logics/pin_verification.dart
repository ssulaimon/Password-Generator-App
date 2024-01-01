// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutterleaner/db/db_service.dart';
import 'package:flutterleaner/screens/passwords.dart';

class PinVerification {
  static String? validatePin({required String pin}) {
    if (pin.isEmpty) {
      return 'Pin cannot be empty';
    } else if (pin.length < 4) {
      return 'Pin is lower than required';
    } else {
      return null;
    }
  }

  static Future<String?> validateSettingsPin(
      {required String pin, required BuildContext context}) async {
    final int? userPin = await DataBaseHelper().myPin();
    if (pin.isEmpty) {
      return 'Pin cannot be empty';
    } else if (pin.length < 4) {
      return 'Pin is too short';
    } else if (int.parse(pin) != userPin) {
      return "Incorrect Pin";
    } else {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const PasswordsScreens()));
      return null;
    }
  }
}
