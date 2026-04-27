import 'package:civicspot/core/theme/app_colors.dart';
import 'package:civicspot/features/splash/controllers/splash_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SplashView extends GetView<SplashControllers> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Icon(
              Icons.location_off_rounded,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 16,),
            Text(
                "CivicSpot",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 8,),
            Text(
              "City Issues Reporter",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 48,),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
