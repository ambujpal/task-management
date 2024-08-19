import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/provider/create_task_provider.dart';
import 'package:task_management/provider/home_provider.dart';
import 'package:task_management/provider/splash_provider.dart';
import 'package:task_management/provider/task_details_provider.dart';
import 'package:task_management/utils/routes/routes.dart';
import 'package:task_management/utils/routes/routes_name.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SplashProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => CreateTaskProvider()),
    ChangeNotifierProvider(create: (_) => TaskDetailsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.wrapScreen,
      onGenerateRoute: AppRoutes.generateRoute,
      // home: const WrapperScreen(),
    );
  }
}
