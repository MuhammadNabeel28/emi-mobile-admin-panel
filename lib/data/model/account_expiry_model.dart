class AccountExpiryModel {
  bool? success;
  String? message;
  int? accountId;
  bool? expiredStatus;

  AccountExpiryModel(
      {this.success, this.message, this.accountId, this.expiredStatus});

  AccountExpiryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    accountId = json['accountId'];
    expiredStatus = json['expiredStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['accountId'] = accountId;
    data['expiredStatus'] = expiredStatus;
    return data;
  }
}
