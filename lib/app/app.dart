import 'package:emi_solution/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:emi_solution/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:emi_solution/ui/views/home/home_view.dart';
import 'package:emi_solution/ui/views/login/login_view.dart';
import 'package:emi_solution/ui/views/splash/splash_view.dart';
import 'package:emi_solution/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SplashView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
