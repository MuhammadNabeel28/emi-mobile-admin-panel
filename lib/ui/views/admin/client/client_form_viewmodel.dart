import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:emi_solution/data/model/account_create_model.dart';
import 'package:emi_solution/data/repo/get/get_repository.dart';
import 'package:emi_solution/data/repo/post/post_repository.dart';
import 'package:emi_solution/ui/common/class/formcontrol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class ClientFormViewModel extends BaseViewModel {
  bool _ismaster = false;
  bool get ismaster => _ismaster;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  CreateAccountModel? createAccountModel;
  bool isMasterAccount = false;
  final getRepo = GetRepository();
  final postRepo = PostRepository();
  bool isCreating = false;
  bool isPasswordVisible = true;
  final formManager = ControlManager();

  @override
  void dispose() {
    formManager.dispose();
    super.dispose();
  }

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
        formManager.accountIdController.text =
            accountIdModel.accountId.toString();
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
      accountId: int.parse(formManager.accountIdController.text),
      accountName: formManager.accountNameController.text,
      contactInfo: formManager.contactInfoController.text,
      isMaster: ismaster,
      dateOfExpiry: formManager.dateController.text,
      userId: formManager.userIdController.text,
      password: formManager.passwordController.text,
      deviceLimit: int.parse(formManager.deviceLimitController.text),
      email: formManager.emailController.text,
    );

   // createAccountModel = response;

    // ignore: unrelated_type_equality_checks
    if (response.code == 200) {
      // Clear the form after successful creation
      formManager.clearForm();
      toggleIsMaster(false);
    }

    isCreating = false;
    rebuildUi();
    
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
