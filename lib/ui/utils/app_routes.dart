
import 'package:evenlyproject/ui/screens/navigation/tabs/home/home_tab.dart';
import 'package:evenlyproject/ui/screens/on_boarding/on_boarding_screen.dart';
import 'package:evenlyproject/ui/screens/on_boarding/page_view_screen.dart';
import 'package:flutter/material.dart';
import '../screens/add_event/add_event_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/navigation/navigation_screen.dart';
import '../screens/register/register_screen.dart';

abstract final class AppRoutes {
  static MaterialPageRoute get login =>
      MaterialPageRoute(builder: (_) => const LoginScreen());

  static MaterialPageRoute get register =>
      MaterialPageRoute(builder: (_) => const RegisterScreen());

  static MaterialPageRoute get navigation =>
      MaterialPageRoute(builder: (_) => const NavigationScreen());

  static MaterialPageRoute get addEvent =>
      MaterialPageRoute(builder: (_) => const AddEventScreen());
  static MaterialPageRoute get onBoarding =>
      MaterialPageRoute(builder: (_) => const OnBoardingScreen());
  static MaterialPageRoute get pageView =>
      MaterialPageRoute(builder: (_) => const PageViewScreen());
  static MaterialPageRoute get homeTab =>
      MaterialPageRoute(builder: (_) => const HomeTab());

}