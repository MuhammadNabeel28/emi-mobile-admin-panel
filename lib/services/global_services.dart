import 'package:emi_solution/data/local/aap_storage.dart';

class GlobalServices {
  String? userName = "";
  String? email = "";
  String? clientName = "";
  int? accountId = 0;

  String? getUserName() {
    userName = LocalStorage.getString(LocalStorage.userNameKey);
    return userName;
  }
}
