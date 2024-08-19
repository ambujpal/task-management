import 'dart:async';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  SplashProvider() {
    autoNavigate();
  }

  Future<void> autoNavigate() async {
    Future.delayed(const Duration(seconds: 3), () {
      _isInitialized = true;
      notifyListeners();
    });
  }
}
