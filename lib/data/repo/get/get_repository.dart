import 'package:emi_solution/data/api/api_client.dart';
import 'package:emi_solution/data/model/account_detail_model.dart';

class GetRepository {
  final ApiClient apiClient = ApiClient();
  AccountDetailModel? accountDetailModel;

  //! get account detail repo
  Future<AccountDetailModel> getAccountDetail(String token) async {
    final response = await apiClient.getAccountDetail(token: token);
    return AccountDetailModel.fromJson(Map<String, dynamic>.from(response));
  }
}
