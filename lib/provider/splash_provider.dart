import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/utils/routes/routes_name.dart';

class SplashProvider with ChangeNotifier {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  SplashProvider() {
    // Initialization logic
    // startNavigation(context);
  }

  void startNavigation(context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoNavigate(context);
    });
  }

  Future<void> autoNavigate(context) async {
    await Future.delayed(const Duration(seconds: 3));
    _isInitialized = true;
    checkLoginStatus(context);
    notifyListeners();
  }

  Future<void> checkLoginStatus(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    if (isLoggedIn == true) {
      Navigator.pushReplacementNamed(context, AppRoutesName.homeScreen);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutesName.loginScreen);
    }
  }
}
