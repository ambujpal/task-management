import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/provider/splash_provider.dart';
import 'package:task_management/style/app_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SplashProvider>(context, listen: false);
      provider.autoNavigate(context);
    });

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
