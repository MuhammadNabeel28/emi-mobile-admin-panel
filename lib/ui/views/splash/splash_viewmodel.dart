import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:emi_solution/app/app.locator.dart';
import 'package:emi_solution/app/app.router.dart';
import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewmodel extends BaseViewModel {
  final _navigationServices = locator<NavigationService>();
  final localStorage = LocalStorage();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final Logger logger = Logger();

  void navigateToNext() async {
    getDeviceId();
    final isFirstLaunch =
        LocalStorage.getbool(LocalStorage.launchFirstKey) ?? true;
    final islogin = LocalStorage.getbool(LocalStorage.isLoginKey) ?? false;
    final isMaster = LocalStorage.getbool(LocalStorage.isMasterKey) ?? false;

    if (islogin && isMaster) {
      await Future.delayed(const Duration(seconds: 2), () {
        _navigationServices.replaceWithAdminView();
      });
    } else if (islogin && !isMaster) {
      await Future.delayed(const Duration(seconds: 2), () {
        _navigationServices.replaceWithCustomerView();
      });
    } else if (isFirstLaunch) {
      await Future.delayed(const Duration(seconds: 2), () {
        _navigationServices.replaceWithStartupView();
      });
    } else {
      await Future.delayed(const Duration(seconds: 2), () {
        _navigationServices.replaceWithLoginView();
      });
    }
  }

  void getDeviceId() async {
    try {
      String? deviceId;

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }

      LocalStorage.setString(LocalStorage.deviceIdKey, deviceId!);

      logger.i("(Splash Screen) : Get DeviceId: $deviceId");
    } catch (e) {
      logger.e("(Splash Screen) : Error getting deviceId: $e");
    }
  }
}
