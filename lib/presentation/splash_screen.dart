import 'package:flutter/material.dart';
import 'package:task_management/style/app_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.appLogo,
          height: 110,
          width: 110,
        ),
      ),
    );
  }
}
