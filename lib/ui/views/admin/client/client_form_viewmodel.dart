import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ClientFormViewModel extends BaseViewModel {
  bool _ismaster = false;
  late final DateTime? pickedDate;
  final TextEditingController dateController = TextEditingController();
  bool get ismaster => _ismaster;
  void toggleIsMaster(bool value) {
    print('kaam ki value $value');
    _ismaster = value;
    notifyListeners();
  }
}
