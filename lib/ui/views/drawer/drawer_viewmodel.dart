import 'package:emi_solution/app/app.locator.dart';
import 'package:emi_solution/app/app.router.dart';
import 'package:emi_solution/services/global_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DrawerViewModel extends BaseViewModel {
  final NavigationService navigationService_ = locator<NavigationService>();
  final globalService = locator<GlobalServices>();

  void logOut() {
    navigationService_.replaceWithLoginView();
  }

  Future<String?> getUserName() async {
    String? name = await globalService.getUserName();
    return name;
  }
}
