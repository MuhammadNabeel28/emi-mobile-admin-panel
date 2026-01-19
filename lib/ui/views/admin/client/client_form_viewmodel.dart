import 'package:flutter/material.dart';
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
}
