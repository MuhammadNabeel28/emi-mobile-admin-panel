import 'dart:convert';
import 'package:emi_solution/app/app.locator.dart';
import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:emi_solution/data/model/account_detail_model.dart';
import 'package:emi_solution/data/repo/get/get_repository.dart';
import 'package:emi_solution/data/repo/post/post_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminDashboardViewModel extends BaseViewModel {
  final navigationServices = locator<NavigationService>();
  final LocalStorage localStorage = LocalStorage();
  bool isSwitchedExpire = false;
  bool isSwitchedActive = false;
  List<AccountDetailModel>? acDetailModel;
  final getRepo = GetRepository();
  final postRepo = PostRepository();
  final txtdevicelimit = TextEditingController();

  void loadDetail() async {
    String? token = LocalStorage.getString(LocalStorage.accessTokenKey);
    getRepo.getAccountDetail(token!).then((acDetailResponse) {
      acDetailModel = acDetailResponse;
      debugPrint(jsonEncode(acDetailModel), wrapWidth: 1024);
      notifyListeners();
    });
  }

  void toggleExpired(int index, bool value) async {
    isSwitchedExpire = value;
    final response = await postRepo.postAccountExpiry(
      accountId: acDetailModel![index].accountId!,
      expiredStatus: value,
      loginId: (await LocalStorage.getInt(LocalStorage.userLoginIdKey))!,
    );
    if (response.success == true) {
      acDetailModel?[index].isExpired = value;
    } else {
      acDetailModel?[index].isExpired = !value;
    }

    notifyListeners();
  }

  void toggleActive(int index, bool value) async {
    isSwitchedActive = value;
    final response = await postRepo.postAccountActive(
      accountId: acDetailModel![index].accountId!,
      activeStatus: value,
      loginId: (await LocalStorage.getInt(LocalStorage.userLoginIdKey))!,
    );

    if (response.success == true) {
      acDetailModel?[index].activeStatus = value;
    } else {
      acDetailModel?[index].activeStatus = !value;
    }
    notifyListeners();
  }
}
