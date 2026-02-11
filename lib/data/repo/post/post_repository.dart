import 'package:emi_solution/data/api/api_client.dart';
import 'package:emi_solution/data/local/aap_storage.dart';
import 'package:emi_solution/data/model/account_active_model.dart';
import 'package:emi_solution/data/model/account_create_model.dart';
import 'package:emi_solution/data/model/account_expiry_model.dart';
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

  //! account active post repo
  Future<AccountActiveModel> postAccountActive({
    required int accountId,
    required bool activeStatus,
    required int loginId,
  }) async {
    Map<String, dynamic> response = await apiClient.postAccountActive(
      accountId: accountId,
      activeStatus: activeStatus,
      loginId: loginId,
      token: LocalStorage.getString(LocalStorage.accessTokenKey)!,
    );
    return AccountActiveModel.fromJson(response);
  }

  //! account expiry post repo
  Future<AccountExpiryModel> postAccountExpiry({
    required int accountId,
    required bool expiredStatus,
    required int loginId,
  }) async {
    Map<String, dynamic> response = await apiClient.postAccountExpiry(
      accountId: accountId,
      expiredStatus: expiredStatus,
      loginId: loginId,
      token: LocalStorage.getString(LocalStorage.accessTokenKey)!,
    );
    return AccountExpiryModel.fromJson(response);
  }

  //! new account create post repo
  Future<CreateAccountModel> postCreateNewAccount({
    required int loginId,
    required int accountId,
    required String accountName,
    required String contactInfo,
    required bool isMaster,
    required String dateOfExpiry,
    required String userId,
    required String password,
    required int deviceLimit,
    required String email,
  }) async {
    Map<String, dynamic> response = await apiClient.postCreateAccount(
      loginId: loginId,
      accountId: accountId,
      accountName: accountName,
      contactInfo: contactInfo,
      isMaster: isMaster,
      dateOfExpiry: dateOfExpiry,
      userId: userId,
      password: password,
      deviceLimit: deviceLimit,
      email: email,
      token: LocalStorage.getString(LocalStorage.accessTokenKey)!,
    );
    return CreateAccountModel.fromJson(response);
  }
}
