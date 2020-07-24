import 'package:avalinks/screen/BlogListScreen.dart';
import 'package:avalinks/screen/ChangePasswordScreen.dart';
import 'package:avalinks/screen/CountryListScreen.dart';
import 'package:avalinks/screen/ForgotPasswordScreen.dart';
import 'package:avalinks/screen/LoginScreen.dart';
import 'package:avalinks/screen/ProfileScreen.dart';
import 'package:avalinks/screen/RegisterScreen.dart';
import 'package:avalinks/screen/user/UserMainScreen.dart';
import 'package:avalinks/screen/vendor/ServiceAddUpdateScreen.dart';
import 'package:avalinks/screen/vendor/ServiceCategoryListScreen.dart';
import 'package:avalinks/screen/vendor/ServiceListScreen.dart';
import 'package:avalinks/screen/vendor/SubcriptionScreen.dart';
import 'package:avalinks/screen/vendor/VendorHomeScreen.dart';

final routes = {
  '/get_country': (context) => new CountryListScreen(),
  '/login': (context) => new LoginScreen(),
  '/register': (context) => new RegisterScreen(),
  '/forgot_password': (context) => new ForgotPasswordScreen(),
  '/blog_list': (context) => new BlogListScreen(),
  '/profile': (context) => new ProfileScreen(),
  '/changePassword': (context) => new ChangePasswordScreen(),
  '/user_home': (context) => new UserMainScreen(),
  '/vendor_home': (context) => new VendorHomeScreen(),
  '/service_category_list': (context) => new ServiceCategoryListScreen(),
  '/vendor_service_list': (context) => new ServiceListScreen(),
  '/service_add_update': (context) => new ServiceAddUpdateScreen(),
  '/blog_list': (context) => new BlogListScreen(),
  '/subscription': (context) => new SubscriptionScreen(),
};
