import 'package:dio/dio.dart';
import 'package:emi_solution/data/api/api_url.dart';
import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:emi_solution/ui/widget/custom_snackbar.dart';
import 'package:logger/logger.dart';

class ApiClient {
  final dio = Dio();
  final Logger logger = Logger();
  final localStorage = LocalStorage();

  //! login request
  Future<Map<String, dynamic>> postLogin({
    required userName,
    required password,
    required deviceId,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      'userId': userName,
      'password': password,
      'deviceId': deviceId,
    };

    try {
      final response = await dio.post(
        ApiUrl.loginUrl,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        logger.i(
            "(Api CLient request login success!!)  : login response: ${response.data}");
        return response.data;
      } else if (response.statusCode == 401) {
        final refreshResult = await postRefreshToken(
          token: LocalStorage.getString(LocalStorage.userNameKey),
          refreshToken: LocalStorage.getString(LocalStorage.refreshTokenKey),
        );

        logger.i("(Api Client  Class) refreseh Token ${refreshResult.toString()}");

        return {
          "success": false,
          "message": "Unauthorized. Refresh attempted.",
          "refreshResponse": refreshResult,
        };
      } else {
        logger.e("(Api CLient request login error)  : Error Message: ${response.statusMessage}}");

        return {"success": false, "message": response.statusMessage};
      }
    } catch (e) {
      AppSnackBar.showError('$e');
      return {"success": false, "message": e.toString()};
    }
  }

  //! refresh token request
  Future<Map<String, String>> postRefreshToken(
      {required token, required refreshToken}) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      'userId': token,
      'refreshToken': refreshToken,
    };
    try {
      final response = await dio.post(
        ApiUrl.refreshUrl,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        logger.i("(Api CLient request refreshToken success!!)  : refreshToken: ${response.data}");
        return response.data;
      } else {
        logger.e("(Api CLient request refreshToken error )  : Error Message: ${response.statusMessage}}");

        return {
          "success": "false",
          "message": response.statusMessage ?? "Unknown error"
        };
      }
    } catch (e) {
      AppSnackBar.showError(
        e.toString(),
      );
      return {"success": "false", "message": e.toString()};
    }
  }
}
