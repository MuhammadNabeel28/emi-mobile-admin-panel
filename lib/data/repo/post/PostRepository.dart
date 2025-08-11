import 'package:emi_solution/data/api/api_client.dart';
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
}
