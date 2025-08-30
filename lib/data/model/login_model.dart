class LoginModel {
  String? accessToken;
  String? refreshToken;
  int? accountId;
  String? userId;
  String? userName;
  bool? isMaster;
  String? message;
  bool? success;

  LoginModel(
      {this.accessToken,
      this.refreshToken,
      this.accountId,
      this.userId,
      this.userName,
      this.isMaster,
      this.message,
      this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    accountId = json['accountId'];
    userId = json['userId'];
    userName = json['userName'];
    isMaster = json['isMaster'];
    message = json['message'];
    success = json['success'];
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
    return data;
  }
}
