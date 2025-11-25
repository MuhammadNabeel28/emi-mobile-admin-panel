import 'package:emi_solution/data/api/api_client.dart';
import 'package:emi_solution/data/model/account_detail_model.dart';

class GetRepository {
  final ApiClient apiClient = ApiClient();
  AccountDetailModel? accountDetailModel;

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
}
