class Api {
  //base Urls
  static const String baseUrl = "$base/api/v2/";

  static const String base = "https://beta.claimizer.com";

  static String getAdditionalServiceApiCall(String type) => "$type/categories";

  static const String refreshTokenApiCall = "auth/refresh";
  static const String loginApiCall = "login";
  static const String registerApiCall = "register";
  static const String statisticsApiCall = "statistics";
}
