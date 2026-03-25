import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startApp();
  }

  Future<void> startApp() async {
    final prefs = await SharedPreferences.getInstance();

    final bool seenOnboard = prefs.getBool('seenOnboard') ?? false;
    final bool isLoggedIn = prefs.getBool("isLoggedIn") ?? true;

    await Future.delayed(const Duration(seconds: 2));

    if (!seenOnboard) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
    else if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    }
    else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(Icons.flutter_dash_sharp, size: 80, color: AppColors.backgroundLight),
            SvgPicture.asset("assets/images/NIA_logo.svg", height: 300,),
          ],
        ),
      ),
    );
  }
}