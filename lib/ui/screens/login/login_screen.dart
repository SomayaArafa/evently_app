import 'package:evenlyproject/ui/utils/app_assets.dart';
import 'package:evenlyproject/ui/utils/app_routes.dart';
import 'package:evenlyproject/ui/utils/app_styles.dart';
import 'package:evenlyproject/ui/widgets/evently_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../../widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.appLogo),
              const SizedBox(height: 48),
              const Text('Login to your account',style: AppTextStyles.blue24SemiBold,),
              const SizedBox(height: 24),
              AppTextField(
                hint: 'Enter your email',
                prefixIcon: SvgPicture.asset(AppAssets.icEmailSvg),
              ),
              const SizedBox(height: 16),
              AppTextField(
                hint: 'Enter your password',
                suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                prefixIcon: SvgPicture.asset(AppAssets.icLockSvg),
                isPassword: true,
              ),
              const SizedBox(height: 8),
              Text(
                'Forget password?',
                textAlign: TextAlign.end,
                style: AppTextStyles.blue14SemiBold.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 48),
              EventlyButton(text: 'Login', onPress: (){}),
              const SizedBox(height: 48),
              InkWell(
                onTap: () {
                  Navigator.push(context, AppRoutes.register);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account? ',
                      style: AppTextStyles.grey14Regular,
                    ),
                    Text(
                      'sign up',
                      style: AppTextStyles.blue14SemiBold.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Or',
                textAlign: TextAlign.center,
                style: AppTextStyles.blue14SemiBold,
              ),
              const SizedBox(height: 32),
              EventlyButton(
                text: 'login with google',
                onPress: () {},
                backgroundColor: AppColors.white,
                textStyle: AppTextStyles.blue18Medium,
                icon: const Icon(Icons.g_mobiledata),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
