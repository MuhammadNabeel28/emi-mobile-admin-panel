import 'package:emi_solution/app/app.locator.dart';
import 'package:emi_solution/app/app.router.dart';
import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewmodel extends BaseViewModel {
  final _navigationServices = locator<NavigationService>();
  final localStorage = LocalStorage();

  void navigateToNext() {
    
    final isFirstLaunch =
        LocalStorage.getbool(LocalStorage.launchFirstKey) ?? true;
    final islogin = LocalStorage.getbool(LocalStorage.isLoginKey) ?? false;

    if (isFirstLaunch && islogin) {
      _navigationServices.replaceWithHomeView();
    } else if (!islogin) {
      _navigationServices.replaceWithLoginView();
    } else {
      _navigationServices.replaceWithStartupView();
    }
  }
}
