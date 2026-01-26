
import 'package:flutter/material.dart';
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

  // static MaterialPageRoute get addEvent =>
  //     MaterialPageRoute(builder: (_) => AddEventScreen());
}