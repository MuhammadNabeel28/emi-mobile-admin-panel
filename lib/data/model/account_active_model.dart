class AccountActiveModel {
  bool? success;
  String? message;
  int? accountId;
  bool? activeStatus;

  AccountActiveModel(
      {this.success, this.message, this.accountId, this.activeStatus});

  AccountActiveModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    accountId = json['accountId'];
    activeStatus = json['activeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['accountId'] = accountId;
    data['activeStatus'] = activeStatus;
    return data;
  }
}
