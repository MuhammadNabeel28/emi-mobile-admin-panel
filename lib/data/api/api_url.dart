class ApiUrl {
  static const String baseUrl = 'http://cloud.swisssoft.co:1090';
  static const String loginUrl = '$baseUrl/api/Auth/login';
  static const String refreshUrl = '$baseUrl/api/Auth/refresh';
  static const String createAccountUrl = '$baseUrl/api/Account/create';
  static const String getAccountDetail = '$baseUrl/api/Account/accountsInfo';
  static const String postAccountActiveInActive = '$baseUrl/api/Account/activestatus_update';

  // Add more endpoints as needed
}
