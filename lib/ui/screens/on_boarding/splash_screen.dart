import 'package:evenlyproject/ui/utils/app_assets.dart';
import 'package:evenlyproject/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToOnboarding();
  }

  void navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.push(context, AppRoutes.onBoarding);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Image.asset(
              AppAssets.appLogo,
            ),
            const Spacer(),
            Image.asset(AppAssets.routeLogo),
            const SizedBox(
              height: 8,
            ),
            const Text('Supervised by Mohamed Nabil'),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }
}
