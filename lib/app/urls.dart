class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String loginUrl = '$_baseUrl/auth/login';
  static const String signupUrl = '$_baseUrl/auth/signup';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String homeSliderUrl = '$_baseUrl/slides';
  static const String categoryListUrl = '$_baseUrl/categories';
  static const String productListUrl = '$_baseUrl/products';
  static const String cartUrl = '$_baseUrl/cart';
  static const String wishlistUrl = '$_baseUrl/wishlist';

  static String productDetailsByIdUrl(String productId) =>
      '$_baseUrl/products/id/$productId';
}
