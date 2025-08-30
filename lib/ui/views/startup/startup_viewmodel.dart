import 'package:stacked/stacked.dart';
import 'package:emi_solution/app/app.locator.dart';
import 'package:emi_solution/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  bool isLoading = false;

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 1));
    _navigationService.replaceWithLoginView();
  }
}
