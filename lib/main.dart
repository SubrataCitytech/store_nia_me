import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';

void main() {
  runApp(const NIAApp());
}

class NIAApp extends StatelessWidget {
  const NIAApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NIA',
      // home: const SplashScreen(),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}

