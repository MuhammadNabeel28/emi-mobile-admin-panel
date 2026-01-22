import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ClientFormViewModel extends BaseViewModel {
  bool _ismaster = false;
  late final DateTime? pickedDate;
  final TextEditingController dateController = TextEditingController();
  bool get ismaster => _ismaster;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController accountIdController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController contactInfoController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController deviceLimitController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateOfExpiryController = TextEditingController();
  bool isMasterAccount = false;

  void toggleIsMaster(bool value) {
    _ismaster = value;
    notifyListeners();
  }

    numberformater() {
    ContactNumberFormatter();
  }
}

class ContactNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll('-', '');
    var buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      // Example: after 4 digits, add a dash
      if (i == 3 || i == 6) {
        buffer.write('-');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
