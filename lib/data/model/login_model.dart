class LoginModel {
  String? accessToken;
  String? refreshToken;
  int? accountId;
  String? userId;
  String? userName;
  bool? isMaster;
  String? message;
  bool? success;
  int? loginId;
  bool? activeStatus;
  bool? expiryStatus;

  LoginModel(
      {this.accessToken,
      this.refreshToken,
      this.accountId,
      this.userId,
      this.userName,
      this.isMaster,
      this.message,
      this.success,
      this.loginId,
      this.activeStatus,
      this.expiryStatus});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    accountId = json['accountId'];
    userId = json['userId'];
    userName = json['userName'];
    isMaster = json['isMaster'];
    message = json['message'];
    success = json['success'];
    loginId = json['loginId'];
    activeStatus = json['active'];
    expiryStatus = json['expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['accountId'] = accountId;
    data['userId'] = userId;
    data['userName'] = userName;
    data['isMaster'] = isMaster;
    data['message'] = message;
    data['success'] = success;
    data['loginId'] = loginId;
    data['active'] = activeStatus;
    data['expiry'] = expiryStatus;
    return data;
  }
}
