class UrlUtils {
  static const String BASE_URL = "http://avalinks.freshcodes.in/webservice/";

  static const String GET_COUNTRY = "search/getCountry";

  static const String LOGIN = "user/userLogin";
  static const String SOCIAL_LOGIN = "user/socialLogin";
  static const String REGISTER = "user/signupUser";
  static const String FORGOT_PASSWORD = "user/forgotPassword";
  static const String CHANGE_PASSWORD = "user/changePassword";
  static const String EDIT_PROFILE = "user/editUserProfile";
  static const String SEARCH = "search/getSearch";
  static const String SERVICE_LIST = "service/getServiceList";
  static const String BLOG_LIST = "blog/getBlogList";
  static const String AFFILIATE_PRODUCT_LIST = "affiliate/getAffiliateList";
  static const String CATEGORY_LIST = "service/getCategoryList";
  static const String ADD_SERVICE = "service/addService";
  static const String EDIT_SERVICE = "service/editService";
  static const String DELETE_SERVICE_MEDIA = "service/deleteServiceMedia";
  static const String DELETE_SERVICE = "service/deleteService";
  static const String MEMBERSHIP_PLANS = "membership/getMemberList";

  static const String FACEBOOK_GRAPH_URL =
      "https://graph.facebook.com/v2.12/me";

  static const String PAYMENT =
      "http://avalinks.freshcodes.in/third_party/braintree/payment_gateway/index.php";
  static const String PAYMENT_CALLBACK =
      "http://avalinks.freshcodes.in/third_party/braintree/payment_gateway/callback.php";
}
