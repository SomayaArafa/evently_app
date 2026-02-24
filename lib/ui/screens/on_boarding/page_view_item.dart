import 'package:evenlyproject/ui/utils/app_assets.dart';
import 'package:evenlyproject/ui/utils/app_colors.dart';
import 'package:evenlyproject/ui/utils/app_routes.dart';
import 'package:evenlyproject/ui/utils/app_styles.dart';
import 'package:evenlyproject/ui/widgets/evently_button.dart';
import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback onNext;
  final bool isLast;
  final int currentIndex;

  const PageViewItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.onNext,
    required this.isLast,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 30,
              ),
              Image.asset(
                AppAssets.appLogo,
                height: 30,
              ),
              isLast
                  ? const SizedBox()
                  : InkWell(
                      onTap: (){Navigator.push(context, AppRoutes.login);},
                      child: Container(decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                        child: const Text(
                          "Skip",
                          style: AppTextStyles.blue14SemiBold,
                        ),
                      ),
                    ),
            ],
          ),
          const Spacer(),
          Image.asset(image, height: 250),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == index ? 12 : 8,
                height: currentIndex == index ? 12 : 8,
                decoration: BoxDecoration(
                  color:
                      currentIndex == index ? AppColors.blue : AppColors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(alignment: Alignment.topLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
          const Spacer(),
          EventlyButton(
            onPress: onNext,
            text: isLast ? "Get Started" : "Next",
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
