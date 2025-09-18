import 'package:emi_solution/app/app.bottomsheets.dart';
import 'package:emi_solution/app/app.dialogs.dart';
import 'package:emi_solution/app/app.locator.dart';
import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:emi_solution/ui/common/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  bool _isProcessingTap = false;
  bool isMaster = false;

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  HomeViewModel() {
    isMaster = LocalStorage.getbool(LocalStorage.isMasterKey) ?? false;
  }

  Future<void> setIndex(int index) async {
    if (_currentIndex == index || _isProcessingTap) return;

    _isProcessingTap = true;
    _currentIndex = index;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 50));
    _isProcessingTap = false;
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
