// ignore_for_file: strict_top_level_inference

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:emi_solution/data/api/api_url.dart';
import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:emi_solution/ui/widget/custom_snackbar.dart';
import 'package:logger/logger.dart';

class ApiClient {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    headers: {
      "Content-Type": "application/json",
      "ngrok-skip-browser-warning":
          "true", // Ya "69420", "1", "anyvalue" – kuch bhi non-empty
    },
  ))
    ..httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
  final Logger logger = Logger();
  final localStorage = LocalStorage();

  //! login request
  Future<Map<String, dynamic>> postLogin({
    required userName,
    required password,
    required deviceId,
  }) async {
    // final headers = {
    //   'Content-Type': 'application/json',
    // };

    final body = {
      'userId': userName,
      'password': password,
      'deviceId': deviceId,
    };

    try {
      final response = await dio.post(
        ApiUrl.loginUrl,
        data: body,
        //options: Options(headers: dio.h),
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

  //! get account id
  Future<dynamic> getAccountId({required String token}) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.get(
        ApiUrl.getAccountIdUrl,
        options: Options(
          headers: headers,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      logger.i("Response status: ${response.statusCode}");
      logger.i("Response type: ${response.data.runtimeType}");
      logger.i("Response body: ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 401) {
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
          LocalStorage.setString(LocalStorage.accessTokenKey, newToken!);
          return await getAccountId(token: newToken!);
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
      logger.e("getAccountId exception: ${e.toString()}");
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  //! get account detail
  Future<dynamic> getAccountDetail({required String token}) async {
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
          return response.data; // single object
        } else if (response.data is List && response.data.isNotEmpty) {
          return response.data; // full list, not just [0]
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
          LocalStorage.setString(LocalStorage.accessTokenKey, newToken!);
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

  //! account active/inactive request
  Future<Map<String, dynamic>> postAccountActive({
    required bool activeStatus,
    required int accountId,
    required int loginId,
    required String token,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {
      'status': activeStatus,
      'loginId': loginId,
      'accountId': accountId,
    };

    try {
      final response = await dio.post(
        ApiUrl.postAccountActiveInActive,
        data: body,
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        AppSnackBar.showSuccess(
            activeStatus ? 'Account Activated' : 'Account Deactivated');
        logger.i(
            "(Api CLient request account active success!!)  : account active response: ${response.data}");
        return response.data;
      } else if (response.statusCode == 401) {
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

        bool activeStatus_ = activeStatus;
        int accountId_ = accountId;
        int loginId_ = loginId;

        logger.i(
            "(Api Client  Class) refreseh Token ${refreshResult.toString()}");

        if (refreshResult['success'] == true &&
            refreshResult['accessToken'] != null) {
          final newToken = refreshResult['accessToken'];
          LocalStorage.setString(LocalStorage.accessTokenKey, newToken!);
          return await postAccountActive(
            token: newToken!,
            activeStatus: activeStatus_,
            accountId: accountId_,
            loginId: loginId_,
          );
        } else {
          return {
            "success": false,
            "message": "Unauthorized. Token refresh failed.",
            "refreshResponse": refreshResult,
          };
        }
      } else {
        logger.e(
            "(Api CLient request account active error)  : Error Message: ${response.statusMessage}}");

        return {"success": false, "message": response.statusMessage};
      }
    } catch (e) {
      AppSnackBar.showError('$e');
      return {"success": false, "message": e.toString()};
    }
  }

  //! account expiry request
  Future<Map<String, dynamic>> postAccountExpiry({
    required bool expiredStatus,
    required int accountId,
    required int loginId,
    required String token,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {
      'status': expiredStatus,
      'loginId': loginId,
      'accountId': accountId,
    };

    try {
      final response = await dio.post(
        ApiUrl.postAccountExpiry,
        data: body,
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        AppSnackBar.showSuccess(
            expiredStatus ? 'Account Expired' : 'Account Unexpired');
        logger.i(
            "(Api CLient request account expiry success!!)  : account expiry response: ${response.data}");
        return response.data;
      } else if (response.statusCode == 401) {
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

        bool expiredStatus_ = expiredStatus;
        int accountId_ = accountId;
        int loginId_ = loginId;

        logger.i(
            "(Api Client  Class) refreseh Token ${refreshResult.toString()}");

        if (refreshResult['success'] == true &&
            refreshResult['accessToken'] != null) {
          final newToken = refreshResult['accessToken'];
          LocalStorage.setString(LocalStorage.accessTokenKey, newToken!);
          return await postAccountExpiry(
            token: newToken!,
            expiredStatus: expiredStatus_,
            accountId: accountId_,
            loginId: loginId_,
          );
        } else {
          return {
            "success": false,
            "message": "Unauthorized. Token refresh failed.",
            "refreshResponse": refreshResult,
          };
        }
      } else {
        logger.e(
            "(Api CLient request account expiry error)  : Error Message: ${response.statusMessage}}");

        return {"success": false, "message": response.statusMessage};
      }
    } catch (e) {
      AppSnackBar.showError('$e');
      return {"success": false, "message": e.toString()};
    }
  }

  //! create account request
  Future<Map<String, dynamic>> postCreateAccount({
    required int accountId,
    required String accountName,
    required String contactInfo,
    required String userId,
    required int deviceLimit,
    required String email,
    required String password,
    required String dateOfExpiry,
    required bool isMaster,
    required int loginId,
    required String token,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {
      'accountId': accountId,
      'accountName': accountName,
      'contactInfo': contactInfo,
      'userId': userId,
      'deviceLimit': deviceLimit,
      'email': email,
      'password': password,
      'dateOfExpiry': dateOfExpiry,
      'isMaster': isMaster,
      'loginId': loginId,
      'status': true,
    };

    try {
      final response = await dio.post(
        ApiUrl.accountCreateUrl,
        data: body,
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        AppSnackBar.showSuccess('Account Created Successfully');
        logger.i(
            "(Api CLient request create account success!!)  : create account response: ${response.data}");
        return response.data;
      } else {
        logger.e(
            "(Api CLient request create account error)  : Error Message: ${response.statusMessage}}");

        return {"success": false, "message": response.statusMessage};
      }
    } catch (e) {
      AppSnackBar.showError('$e');
      return {"success": false, "message": e.toString()};
    }
  }
}
