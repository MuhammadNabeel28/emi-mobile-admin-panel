import 'package:emi_solution/data/api/api_client.dart';
import 'package:emi_solution/data/model/account_detail_model.dart';
import 'package:emi_solution/data/model/get_accountid_model.dart';

class GetRepository {
  final ApiClient apiClient = ApiClient();
  AccountDetailModel? accountDetailModel;
  GetAccountIdModel? getAccountIdModel;

  //! get account detail repo
  Future<List<AccountDetailModel>> getAccountDetail(String token) async {
    final response = await apiClient.getAccountDetail(token: token);

    if (response is List) {
      return response
          .map((e) => AccountDetailModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else {
      return [AccountDetailModel.fromJson(Map<String, dynamic>.from(response))];
    }
  }

  //! get account id
  Future<GetAccountIdModel?> getAccountId(String token) async {
    final response = await apiClient.getAccountId(token: token);

    if (response != null) {
      getAccountIdModel =
          GetAccountIdModel.fromJson(Map<String, dynamic>.from(response));
      return getAccountIdModel;
    } else {
      return null;
    }
  }
}
