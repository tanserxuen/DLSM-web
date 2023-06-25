import 'package:dlsm_web/auth/views/reset_password_page.dart';
import 'package:dlsm_web/auth/views/sign_in.dart';
import 'package:dlsm_web/auth/views/verification_code_password.dart';
import 'package:dlsm_web/admin/view/dashboard.dart';
import 'package:dlsm_web/common/index.dart';

import '../init_page.dart';

// There will be two types:
// 1. Pages - Individual pages that contain a Scaffold and is usually navigated via Navigator.
// 2. Views - Views that are part of a page. Does not have a Scaffold. Example are views inside
//            a TabBarView.

class Routes {
  //=============
  // Pages
  //=============
  // Core pages
  static const String initPage = '/init';
  static const String loadingPage = '/loading';
  static const String errorPage = '/error';
  // Auth pages
  static const String signInPage = '/sign-in';
  static const String resetPasswordPage = '/reset-password';
  static const String verificationCodePage = '/verification-code';
  // Home pages
  static const String homePage = '/dashboard';

  static final pages = <String, WidgetBuilder>{
    initPage: (BuildContext context) => const InitPage(),
    loadingPage: (BuildContext context) => const LoadingPage(),
    errorPage: (BuildContext context) => const ErrorPage(),
    signInPage: (BuildContext context) => const SignInPage(),
    resetPasswordPage: (context) => const ResetPasswordPage(),
    verificationCodePage: (context) => const VerificationCode(),
    homePage: (context) =>
        const AdminDashboard(title: "Drive Less Save More Admin"),
  };
}
