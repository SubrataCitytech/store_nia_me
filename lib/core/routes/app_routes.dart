import 'package:flutter/cupertino.dart';

import '../../screens/onboarding_screen.dart';
import '../../screens/splash/splash_screen.dart';

class AppRoutes {
  //Routes Name
  static const String splash = '/';
  static const String onboarding = '/onboarding';


  //Route map
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
  };
}