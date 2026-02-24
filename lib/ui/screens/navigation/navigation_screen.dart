
import 'package:evenlyproject/ui/screens/navigation/tabs/favourites/favourites_tab.dart';
import 'package:evenlyproject/ui/screens/navigation/tabs/home/home_tab.dart';
import 'package:evenlyproject/ui/screens/navigation/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';


class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  var selectedIndex = 0;
  var tabs = [const HomeTab(), const FavoriteTab(), const ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: tabs[selectedIndex],
        floatingActionButton: buildFAB(),
        bottomNavigationBar: buildBottomNavigation(),
      ),
    );
  }

  buildFAB() => FloatingActionButton(
    onPressed: () {
      Navigator.push(context, AppRoutes.addEvent);
    },
    backgroundColor: AppColors.blue,
    shape: const CircleBorder(),
    child: const Icon(Icons.add, color: Colors.white),
  );

  Widget buildBottomNavigation() => Theme(
    data: ThemeData(canvasColor: Colors.white),
    child: BottomNavigationBar(
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.grey2,
      currentIndex: selectedIndex,
      onTap: (newIndex){
        selectedIndex = newIndex;
        setState(() {});
      },
      items: [
        buildBottomNavigationBarItem(Icons.home, "Home"),
        buildBottomNavigationBarItem(Icons.favorite_border, "Favorite"),
        buildBottomNavigationBarItem(Icons.person, "Profile"),
      ],
    ),
  );

  BottomNavigationBarItem buildBottomNavigationBarItem(
      IconData iconData,
      String label,
      ) => BottomNavigationBarItem(icon: Icon(iconData), label: label);
}