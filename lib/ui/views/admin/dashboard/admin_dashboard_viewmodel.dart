import 'package:emi_solution/app/app.locator.dart';
import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:emi_solution/data/model/account_detail_model.dart';
import 'package:emi_solution/data/repo/get/get_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminDashboardViewModel extends BaseViewModel {
  final navigationServices = locator<NavigationService>();
  final LocalStorage localStorage = LocalStorage();
  AccountDetailModel? acDetailModel;
  AccountDetailResponse? acDetailResponse;
  final getRepo = GetRepository();

  void loadDetail() async {
    String? token = LocalStorage.getString(LocalStorage.accessTokenKey);
    getRepo.getAccountDetail(token!).then((acDetailResponse) {
      acDetailResponse = acDetailResponse;
      notifyListeners();
    });
  }
}
