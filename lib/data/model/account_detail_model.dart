class AccountDetailModel {
  int? id;
  int? accountId;
  String? accountName;
  String? email;
  String? contactInfo;
  String? licenseKey;
  String? deviceLimit;
  String? expiryDate;
  bool? isMaster;
  bool? isExpired;
  String? createdOn;
  int? createdBy;
  String? modifiedOn;
  int? modifiedBy;

  AccountDetailModel(
      {this.id,
      this.accountId,
      this.accountName,
      this.email,
      this.contactInfo,
      this.licenseKey,
      this.deviceLimit,
      this.expiryDate,
      this.isMaster,
      this.isExpired,
      this.createdOn,
      this.createdBy,
      this.modifiedOn,
      this.modifiedBy});

  AccountDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    accountName = json['accountName'];
    email = json['email'];
    contactInfo = json['contactInfo'];
    licenseKey = json['licenseKey'];
    deviceLimit = json['deviceLimit'];
    expiryDate = json['expiryDate'];
    isMaster = json['isMaster'];
    isExpired = json['isExpired'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountId'] = accountId;
    data['accountName'] = accountName;
    data['email'] = email;
    data['contactInfo'] = contactInfo;
    data['licenseKey'] = licenseKey;
    data['deviceLimit'] = deviceLimit;
    data['expiryDate'] = expiryDate;
    data['isMaster'] = isMaster;
    data['isExpired'] = isExpired;
    data['createdOn'] = createdOn;
    data['createdBy'] = createdBy;
    data['modifiedOn'] = modifiedOn;
    data['modifiedBy'] = modifiedBy;
    return data;
  }
}
