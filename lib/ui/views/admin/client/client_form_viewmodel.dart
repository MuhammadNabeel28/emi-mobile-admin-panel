import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:emi_solution/data/model/account_create_model.dart';
import 'package:emi_solution/data/repo/get/get_repository.dart';
import 'package:emi_solution/data/repo/post/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  CreateAccountModel? createAccountModel;
  bool isMasterAccount = false;
  final getRepo = GetRepository();
  final postRepo = PostRepository();
  bool isCreating = false;
  bool isPasswordVisible = true;

  ClientFormViewModel() {
    getAccountId();
  }

  void toggleIsPasswordVisible() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleIsMaster(bool value) {
    _ismaster = value;
    notifyListeners();
  }

  TextInputFormatter numberformater() {
    return ContactNumberFormatter();
  }

  Future<void> getAccountId() async {
    setBusy(true);
    await Future.delayed(const Duration(seconds: 2));
    final token = LocalStorage.getString(LocalStorage.accessTokenKey);
    if (token != null) {
      final accountIdModel = await getRepo.getAccountId(token);
      if (accountIdModel != null) {
        accountIdController.text = accountIdModel.accountId.toString();
        rebuildUi();
      }
    }
    setBusy(false);
  }

  Future<void> cerateAccount() async {
    isCreating = true;
    rebuildUi();
    await Future.delayed(const Duration(seconds: 2));

    var response = await postRepo.postCreateNewAccount(
      loginId: await LocalStorage.getInt(LocalStorage.userLoginIdKey) ?? 0,
      accountId: int.parse(accountIdController.text),
      accountName: accountNameController.text,
      contactInfo: contactInfoController.text,
      isMaster: ismaster,
      dateOfExpiry: dateController.text,
      userId: userIdController.text,
      password: passwordController.text,
      deviceLimit: int.parse(deviceLimitController.text),
      email: emailController.text,
    );

    // ignore: unrelated_type_equality_checks
    if (response == true) {
      // Clear the form after successful creation
      accountNameController.clear();
      contactInfoController.clear();
      userIdController.clear();
      deviceLimitController.clear();
      emailController.clear();
      passwordController.clear();
      dateController.clear();
      toggleIsMaster(false);
    }

    isCreating = false;
    notifyListeners();
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
      if (i == 3) {
        buffer.write('-');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
