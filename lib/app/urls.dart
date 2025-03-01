class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String loginUrl = '$_baseUrl/auth/login';
  static const String signupUrl = '$_baseUrl/auth/signup';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String homeSliderUrl = '$_baseUrl/slides';

  static const String readProfileUrl = '$_baseUrl/ReadProfile';
  static const String categoryListUrl = '$_baseUrl/CategoryList';

  static String listProductByRemarkUrl(String remark) =>
      '$_baseUrl/ListProductByRemark/$remark';

  static String listProductByCategoryUrl(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';
  static String productDetailsByIdUrl(String productId) =>
      '$_baseUrl/ProductDetailsById/$productId';
}
