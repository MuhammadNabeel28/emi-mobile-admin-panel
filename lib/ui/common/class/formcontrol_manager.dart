import 'package:flutter/material.dart';
mixin StatusCraeate {
 int code = 0;
 String message = '';

}

class ControlManager with StatusCraeate {
  TextEditingController accountIdController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController contactInfoController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController deviceLimitController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime? pickedDate;

  /// Clear all controllers (reset form fields)
  void clearForm() {
    accountIdController.clear();
    accountNameController.clear();
    contactInfoController.clear();
    userIdController.clear();
    deviceLimitController.clear();
    emailController.clear();
    passwordController.clear();
    dateController.clear();
    pickedDate = null;
  }

  /// Dispose all controllers (free memory when screen closes)
  void dispose() {
    accountIdController.dispose();
    accountNameController.dispose();
    contactInfoController.dispose();
    userIdController.dispose();
    deviceLimitController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dateController.dispose();
  }
  
}


