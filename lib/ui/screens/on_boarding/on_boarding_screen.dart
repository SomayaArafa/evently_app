import 'package:evenlyproject/ui/utils/app_colors.dart';
import 'package:evenlyproject/ui/utils/app_routes.dart';
import 'package:evenlyproject/ui/utils/app_styles.dart';
import 'package:evenlyproject/ui/widgets/evently_button.dart';
import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height:24,),
              Image.asset(
                AppAssets.appLogo,
              ),
              const SizedBox(height: 24,),

              Image.asset(
                AppAssets.personalize,
              ),
              const SizedBox(height: 24,),

              const Text(
                'Personalize Your Experience',
                style: AppTextStyles.black20SemiBold,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
                style: AppTextStyles.grey14Regular,
              ),
              const SizedBox(height: 24,),
              Row(
                children: [
                  const Text(
                    'Language',
                    style: AppTextStyles.blue18Medium,
                  ),
                  const Spacer(),
                  Container(height: 35,width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'English',
                        style: AppTextStyles.white18Medium.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Container(height: 35,width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200,width: 1)
                    ),
                    child: const Center(
                      child: Text(
                        'Arabic',
                        style: AppTextStyles.blue14SemiBold,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                children: [
                  const Text(
                    'Theme',
                    style: AppTextStyles.blue18Medium,
                  ),
                  const Spacer(),
                  Container(height: 35,width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Icon(Icons.light_mode,color: AppColors.white,size: 28,)
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Container(height: 35,width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade200,width: 1)
                    ),
                    child: const Center(
                      child: Icon(Icons.dark_mode,color: AppColors.blue,size: 28,)
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12,),
              EventlyButton(text: 'Let’s start', onPress: (){
                Navigator.push(context, AppRoutes.pageView);
              })
            ],
          ),
        ),
      ),
    );
  }
}
