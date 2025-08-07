import 'package:emi_solution/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewmodel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  final _navigationService = locator<NavigationService>();
  bool isChecked = false;
  bool isLoading = false;

  String? validationEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter user name';
    } else {
      return null;
    }
  }

  String? validationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Password';
    } else {
      return null;
    }
  }


  setemail(String? email) {
    emailcontrol.text = email ?? '';
  }

  setPassword(String? password) {
    passwordcontrol.text = password ?? '';
  }
}
