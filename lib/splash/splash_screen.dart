import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:salla_admin/Fetures/admin/presentation/views/dashboard_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/bag/shopping_cart.png',
      splashIconSize: 84,
      nextScreen: const DashboardScreen(),
      backgroundColor: Colors.deepPurpleAccent,
      curve: Curves.bounceInOut,
      splashTransition: SplashTransition.slideTransition,
      //pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}
