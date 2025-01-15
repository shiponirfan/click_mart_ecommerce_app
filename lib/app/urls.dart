class Urls {
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';
  static String verifyEmailUrl(String email) => '$_baseUrl/UserLogin/$email';
  static String verifyOtpUrl(String email, String otp) => '$_baseUrl/VerifyLogin/$email/$otp';
  static const String readProfileUrl = '$_baseUrl/ReadProfile';
  static const String createProfileUrl = '$_baseUrl/CreateProfile';
}