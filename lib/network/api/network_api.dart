class Api {
  //base Urls
  static const String baseUrl = "$base/api/v2/";

  static const String base = "https://beta.claimizer.com";

  static String getAdditionalServiceApiCall(String type) => "$type/categories";

  static const String refreshTokenApiCall = "auth/refresh";
  static const String loginApiCall = "login";
  static const String registerApiCall = "register";
  static const String statisticsApiCall = "statistics";
  static const String claimsApiCall = "claims?per_page=1000";
  static const String profileApiCall = "profile";
  static const String editPasswordApiCall = "change-password";
  static const String editBasicInfo = "profile";
  static const String doAddCommentToClaimApiCall = "claims/comment";
  static const String doAddCommentToUnitRequestApiCall = "requests/addComment";
  static const String buildingsApiCall = "buildings";
  static const String unitsApiCall = "units?per_page=1000";
  static const String unitRequestApiCall = "requests?per_page=1000";
  static const String newLinkRequestApiCall = "requests";
  static const String completeLinkRequestApiCall = "requests/joinUnit";
  static const String renewUnitLinkRequestApiCall = "requests/renew";
  static const String categoriesApiCall = "claims/categories";
  static const String claimTypeApiCall = "claims/claim-types";
  static const String claimAvailableTimeApiCall = "claims/available-times";
  static const String getNotificationApiCall = "show-client-notifications";
  static String getClaimDetailsApiCall(String id) => "claim/$id";
  static String deleteClaimDetailsApiCall(int id) => "claims/$id";
  static String closeClaimDetailsApiCall(String code) => "claim/$code";
  static String getUnitRequestDetailsApiCall(int id) => "request/$id";
  static String unlinkUnitRequestDetailsApiCall = "requests/unlink";

}
