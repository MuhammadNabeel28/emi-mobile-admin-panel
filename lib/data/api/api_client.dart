// ignore_for_file: strict_top_level_inference

import 'dart:convert';

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
          userId: LocalStorage.getString(LocalStorage.userNameKey),
          accountId: LocalStorage.getString(LocalStorage.accountIdKey),
          refreshToken: LocalStorage.getString(LocalStorage.refreshTokenKey),
        );

        logger.i(
            "(Api Client  Class) refreseh Token ${refreshResult.toString()}");

        return {
          "success": false,
          "message": "Unauthorized. Refresh attempted.",
          "refreshResponse": refreshResult,
        };
      } else {
        logger.e(
            "(Api CLient request login error)  : Error Message: ${response.statusMessage}}");

        return {"success": false, "message": response.statusMessage};
      }
    } catch (e) {
      AppSnackBar.showError('$e');
      return {"success": false, "message": e.toString()};
    }
  }

  //! get account detail
  Future<Map<String, dynamic>> getAccountDetail({required String token}) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.get(
        ApiUrl.getAccountDetail,
        options: Options(
          headers: headers,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      logger.i("Response status: ${response.statusCode}");
      logger.i("Response type: ${response.data.runtimeType}");
      logger.i("Response body: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else if (response.data is List && response.data.isNotEmpty) {
          return response.data[0] as Map<String, dynamic>;
        } else {
          return {
            "success": false,
            "message": "Unexpected response format",
          };
        }
      }

      if (response.statusCode == 401) {
        logger.w("Token expired. Attempting refresh...");

        final accountId =
            await LocalStorage.getInt(LocalStorage.accountIdKey) ?? 0;
        final userId = LocalStorage.getString(LocalStorage.userNameKey) ?? '';
        final refreshToken =
            LocalStorage.getString(LocalStorage.refreshTokenKey) ?? '';

        final refreshResult = await postRefreshToken(
          userId: userId,
          accountId: accountId,
          refreshToken: refreshToken,
        );

        logger.i("Refresh result: $refreshResult");

        if (refreshResult['success'] == true &&
            refreshResult['accessToken'] != null) {
          final newToken = refreshResult['accessToken'];
          return await getAccountDetail(token: newToken!);
        } else {
          return {
            "success": false,
            "message": "Unauthorized. Token refresh failed.",
            "refreshResponse": refreshResult,
          };
        }
      }

      return {
        "success": false,
        "message": response.statusMessage ?? "Unknown error",
      };
    } catch (e) {
      AppSnackBar.showError(e.toString());
      logger.e("getAccountDetail exception: ${e.toString()}");
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  //! refresh token request
  Future<Map<String, dynamic>> postRefreshToken(
      {required userId, required refreshToken, required accountId}) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    var data = json.encode({
      "userId": userId,
      "accountId": accountId,
      "refreshToken": refreshToken
    });

    try {
      final response = await dio.post(
        ApiUrl.refreshUrl,
        options: Options(
          headers: headers,
          validateStatus: (status) => status != null && status < 500,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        logger.i(
            "(Api CLient request refreshToken success!!)  : refreshToken: ${response.data}");
        return response.data;
      } else {
        logger.e(
            "(Api CLient request refreshToken error )  : Error Message: ${response.statusMessage}}");

        return {
          "success": "false",
          "message": response.statusMessage ?? "Unknown error"
        };
      }
    } catch (e) {
      AppSnackBar.showError(
        e.toString(),
      );
      logger.e(
          "(Api CLient request refreshToken error )  : Error Message: ${e.toString()}}");
      return {"success": "false", "message": e.toString()};
    }
  }
}
