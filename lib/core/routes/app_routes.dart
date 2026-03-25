import 'package:flutter/cupertino.dart';

import '../../features/auth/login_screen.dart';
import '../../features/screens/main_Screen.dart';
import '../../features/screens/onboarding_screen.dart';
import '../../features/screens/splash/splash_screen.dart';

class AppRoutes {
  //Routes Name
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String main = '/main';


  //Route map
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
    main: (context) => const MainScreen(),

  };
}