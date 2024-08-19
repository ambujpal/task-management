import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/presentation/home_screen.dart';
import 'package:task_management/presentation/splash_screen.dart';
import 'package:task_management/provider/splash_provider.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(builder: (context, provider, child) {
      if (provider.isInitialized) {
        return const HomeScreen();
      } else {
        return const SplashScreen();
      }
    });
  }
}
