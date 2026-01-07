import 'package:stacked/stacked.dart';

class ClientFormViewModel extends BaseViewModel {
  bool _ismaster = false;
  bool get ismaster => _ismaster;
  void toggleIsMaster(bool value) {
    print('kaam ki value $value');
    _ismaster = value;
    notifyListeners();
  }
}
