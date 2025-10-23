import 'package:emi_solution/data/local/aap_storage.dart';

class GlobalServices {
  String? userName = "";
  String? email = "";
  String? clientName = "";
  int? accountId = 0;

  Future<String?> getUserName() async {
    userName = await LocalStorage.getString(LocalStorage.userNameKey);
    return userName;
  }
}
