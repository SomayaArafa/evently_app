import 'package:evenlyproject/ui/screens/on_boarding/page_view_item.dart';
import 'package:evenlyproject/ui/utils/app_assets.dart';
import 'package:evenlyproject/ui/utils/app_routes.dart';
import 'package:flutter/material.dart';

final class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController controller = PageController();
  int currentIndex = 0;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: AppAssets.findEvent,
      title: "Find Events That Inspire You",
      description:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    ),
    OnboardingModel(
      image: AppAssets.effortless,
      title: "Effortless Event Planning",
      description:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    ),
    OnboardingModel(
        image: AppAssets.connect,
        title: 'Connect with Friends & Share Moments',
        description:
            'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.')
  ];

  void nextPage() {
    if (currentIndex == 2) {
      Navigator.push(context, AppRoutes.login);
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: PageView.builder(
        controller: controller,
        itemCount: 3,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return PageViewItem(
            image: pages[index].image,
            title: pages[index].title,
            description: pages[index].description,
            onNext: nextPage,
            isLast: index == 2,
            currentIndex: currentIndex,
          );
        },
      ),
    );
  }
}

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}
