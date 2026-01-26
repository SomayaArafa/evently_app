import 'package:evenlyproject/ui/utils/app_assets.dart';
import 'package:evenlyproject/ui/utils/app_styles.dart';
import 'package:evenlyproject/ui/widgets/evently_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../../widgets/app_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.appLogo),
              const SizedBox(height: 48),
              const Text(
                'Create your account',
                style: AppTextStyles.blue24SemiBold,
              ),
              const SizedBox(height: 24),
              AppTextField(
                hint: 'Enter your name',
                prefixIcon: SvgPicture.asset(AppAssets.icPersonSvg),
              ),
              const SizedBox(height: 16),
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
              AppTextField(
                hint: 'confirm your password',
                suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                prefixIcon: SvgPicture.asset(AppAssets.icLockSvg),
                isPassword: true,
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 48),
              EventlyButton(text: 'Sign up', onPress: () {}),
              const SizedBox(height: 48),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: AppTextStyles.grey14Regular,
                    ),
                    Text(
                      'login',
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
                text: 'Signup with google',
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
