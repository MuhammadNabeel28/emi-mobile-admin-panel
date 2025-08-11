class LoginModel {
  String? accessToken;
  String? refreshToken;
  int? accountId;
  String? userId;
  String? userName;

  LoginModel(
      {this.accessToken,
      this.refreshToken,
      this.accountId,
      this.userId,
      this.userName});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    accountId = json['accountId'];
    userId = json['userId'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['accountId'] = accountId;
    data['userId'] = userId;
    data['userName'] = userName;
    return data;
  }
}
