class CreateAccountModel {
  int? loginId;
  int? accountId;
  String? accountName;
  String? contactInfo;
  bool? isMaster;
  String? dateOfExpiry;
  String? userId;
  String? password;
  int? deviceLimit;
  String? email;
  bool? status;
  String? deviceId;
  String? message;
  String? licenceKey;
  String? numericKey;

  CreateAccountModel(
      {this.loginId,
      this.accountId,
      this.accountName,
      this.contactInfo,
      this.isMaster,
      this.dateOfExpiry,
      this.userId,
      this.password,
      this.deviceLimit,
      this.email,
      this.status,
      this.deviceId,
      this.message,
      this.licenceKey,
      this.numericKey});

  CreateAccountModel.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    accountId = json['accountId'];
    accountName = json['accountName'];
    contactInfo = json['contactInfo'];
    isMaster = json['isMaster'];
    dateOfExpiry = json['dateOfExpiry'];
    userId = json['userId'];
    password = json['password'];
    deviceLimit = json['deviceLimit'];
    email = json['email'];
    status = json['status'];
    deviceId = json['deviceId'];
    message = json['message'];
    licenceKey = json['licenceKey'];
    numericKey = json['numericKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginId'] = loginId;
    data['accountId'] = accountId;
    data['accountName'] = accountName;
    data['contactInfo'] = contactInfo;
    data['isMaster'] = isMaster;
    data['dateOfExpiry'] = dateOfExpiry;
    data['userId'] = userId;
    data['password'] = password;
    data['deviceLimit'] = deviceLimit;
    data['email'] = email;
    data['status'] = status;
    data['deviceId'] = deviceId;
    data['message'] = message;
    data['licenceKey'] = licenceKey;
    data['numericKey'] = numericKey;
    return data;
  }
}
