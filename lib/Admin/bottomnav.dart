import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Admin/home.dart';
import 'package:recipe_app/Admin/profile_admin.dart';
import 'package:recipe_app/pages/Order.dart';
import 'package:recipe_app/pages/all_recipe.dart';
import 'package:recipe_app/pages/home.dart';
import 'package:recipe_app/pages/profile.dart';

class AdminBottomNav extends StatefulWidget {
  const AdminBottomNav({super.key});

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  late List<Widget> pages;

  late AdminHome HomePage;
  late AdminProfile Profile;
  int currentTabIndex = 0;

  @override
  void initState() {
    HomePage = AdminHome();
    Profile = AdminProfile();

    pages = [
      HomePage,
      Profile,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Color(0xffecefe8),
        color: Colors.black,
        animationDuration: Duration(
          milliseconds: 500,
        ),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outlined,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
