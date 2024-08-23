import 'package:flutter/material.dart';
import 'package:task_management/presentation/home_screen.dart';
import 'package:task_management/presentation/login_screen.dart';
import 'package:task_management/presentation/signup_secreen.dart';
import 'package:task_management/presentation/splash_screen.dart';
import 'package:task_management/presentation/wrapper_screen.dart';
import 'package:task_management/style/app_text_style.dart';
import 'package:task_management/utils/routes/routes_name.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.wrapScreen:
        return MaterialPageRoute(builder: (context) => const WrapperScreen());
      case AppRoutesName.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignupSecreen());
      case AppRoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Text(
                "No route defined",
                style: AppTextStyle.ts16MB,
              ),
            ),
          );
        });
    }
  }
}
