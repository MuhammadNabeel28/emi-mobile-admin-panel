import 'package:emi_solution/app/app.locator.dart';
import 'package:emi_solution/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminViewModel extends BaseViewModel {
  final navigationServices = locator<NavigationService>();
  void logout() {
    navigationServices.replaceWithLoginView();
  }
}
