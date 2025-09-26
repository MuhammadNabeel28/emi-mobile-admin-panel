import 'package:emi_solution/app/app.locator.dart';
import 'package:emi_solution/app/app.router.dart';
import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminViewModel extends BaseViewModel {
  final navigationServices = locator<NavigationService>();
  final LocalStorage localStorage = LocalStorage();
  void logout() {
    navigationServices.replaceWithLoginView();
  }

  void loadDetail() {
    
  }
}
