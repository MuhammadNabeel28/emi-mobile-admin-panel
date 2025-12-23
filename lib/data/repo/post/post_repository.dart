import 'package:emi_solution/data/api/api_client.dart';
import 'package:emi_solution/data/model/account_active_model.dart';
import 'package:emi_solution/data/model/login_model.dart';

class PostRepository {
  final apiClient = ApiClient();

  //! login post repo
  Future<LoginModel> postLogin({
    required String username,
    required String password,
    required String deviceId,
  }) async {
    Map<String, dynamic> response = await apiClient.postLogin(
      userName: username,
      password: password,
      deviceId: deviceId,
    );
    return LoginModel.fromJson(response);
  }

  // Future<AccountActiveModel> postAccountActive({
  //   required int accountId,
  //   required bool activeStatus,
  // }) async {
  //   Map<String, dynamic> response = await apiClient.postAccountActive(
  //     accountId: accountId,
  //     activeStatus: activeStatus,
  //   );
  //   return AccountActiveModel.fromJson(response);
  // }
}
