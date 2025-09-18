import 'package:emi_solution/app/app.locator.dart';
import 'package:emi_solution/app/app.router.dart';
import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:emi_solution/data/model/login_model.dart';
import 'package:emi_solution/data/repo/post/PostRepository.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewmodel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  final _navigationService = locator<NavigationService>();
  bool obscurePassword = true;

  bool isChecked = false;
  bool isLoading = false;
  bool isMaster = false;
  final logger = LocalStorage.logger;
  LoginModel? loginModel;
  final postRepo = PostRepository();

  void setObscurePassword() {
    obscurePassword = !obscurePassword;
    rebuildUi();
  }

  void runHomeView() async {
    // isMaster
    //     ? _navigationService.replaceWithAdminView()
    //     : _navigationService.replaceWithCustomerView();

    _navigationService.replaceWithHomeView();
  }

  Future<void> loadCredentials() async {
    try {
      isChecked = LocalStorage.getbool(LocalStorage.rememberKey) ?? false;
      if (isChecked) {
        final String? storedUserName =
            LocalStorage.getString(LocalStorage.userIdKey);
        final String? storedPassword =
            LocalStorage.getString(LocalStorage.passwordKey);
        emailcontrol.text = storedUserName ?? '';
        passwordcontrol.text = storedPassword ?? '';
      } else {
        emailcontrol.text = '';
        passwordcontrol.text = '';
        isChecked = false;
      }
      rebuildUi();
    } catch (e) {
      logger.e("(Login ViewModel) : Error loading credentials from local: $e");
    }
  }

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

  void setemail(String? email) {
    emailcontrol.text = email ?? '';
  }

  void setPassword(String? password) {
    passwordcontrol.text = password ?? '';
  }

  Future<bool> loginUser({
    required String username,
    required String password,
  }) async {
    setBusy(true);
    await Future.delayed(const Duration(seconds: 3));

    try {
      loginModel = await postRepo.postLogin(
        username: username,
        password: password,
        deviceId: LocalStorage.getString(LocalStorage.deviceIdKey)!,
      );

      if (loginModel != null && loginModel!.success == true) {
        LocalStorage.setString(
            LocalStorage.accessTokenKey, loginModel!.accessToken!);
        LocalStorage.setString(LocalStorage.userIdKey, loginModel!.userId!);
        LocalStorage.setString(LocalStorage.userNameKey, username);
        LocalStorage.setString(
            LocalStorage.refreshTokenKey, loginModel!.refreshToken!);
        LocalStorage.setbool(LocalStorage.isLoginKey, true);
        LocalStorage.setbool(LocalStorage.launchFirstKey, true);
        LocalStorage.setInt(LocalStorage.accountIdKey, loginModel!.accountId!);

        LocalStorage.setbool(LocalStorage.launchFirstKey, false);

        isMaster = loginModel!.isMaster!;

        if (isMaster) {
          await LocalStorage.setbool(LocalStorage.isMasterKey, true);
        } else {
          await LocalStorage.setbool(LocalStorage.isMasterKey, false);
        }

        //! check remember status
        isChecked
            ? await LocalStorage.setbool(LocalStorage.rememberKey, true)
            : LocalStorage.getbool(LocalStorage.rememberKey);

        return true;
      } else {
        logger.w("(login viewModel): Login failed - ${loginModel?.message}");
        return false;
      }
    } catch (e) {
      logger.e("(login viewModel): Error logging in: $e");
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<void> showRegularDailog(String? message, String? detail) async {
    await _dialogService.showDialog(
        barrierDismissible: true,
        title: message,
        description: detail,
        dialogPlatform: DialogPlatform.Material);
  }

  void toggleCheckbox(bool value) {
    isChecked = value;
    rebuildUi();
  }
}
