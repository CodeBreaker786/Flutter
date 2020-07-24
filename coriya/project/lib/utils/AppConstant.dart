import 'package:avalinks/models/UserRole.dart';

class AppConstant {
  static const String VENDOR_ROLE_ID_VAL = '2';
  static const String USER_ROLE_ID_VAL = '3';

  static List<UserRole> USER_ROLES = [
    UserRole(role_id: USER_ROLE_ID_VAL, role: 'User'),
    UserRole(role_id: VENDOR_ROLE_ID_VAL, role: 'Vendor'),
  ];

  static const String COUNTRY = "pref_country";
  static const String USER_ROLE_ID = "pref_user_role_id";
  static const String USER_ID = "pref_user_id";
  static const String F_NAME = "pref_fname";
  static const String L_NAME = "pref_lname";
  static const String USER_EMAIL = "pref_user_email";
  static const String USER_PHONE = "pref_user_phone";
  static const String USER_PROFILE_PIC = "pref_profile_pic";

  static const double LIST_BOTTOM_PADDING = 50.0;

  static const String AD_TEST_DEVICE = "CD0BEAA5552212264F6F2EB07B66FBCC";
  static const String APP_ID_ANDROID = "ca-app-pub-5750790574568718~6011123472";
  static const String APP_ID_IOS = "ca-app-pub-5750790574568718~2331307886";
  static const String BANNER_ANDROID = "ca-app-pub-5750790574568718/4191184467";
  static const String BANNER_IOS = "ca-app-pub-5750790574568718/8868796078";
}
