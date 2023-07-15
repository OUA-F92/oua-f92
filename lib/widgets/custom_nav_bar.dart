import 'package:flutter/material.dart';
import 'package:mentoru/ui/home/home_page.dart';
import 'package:mentoru/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../ui/discover/discover_page.dart';
import '../ui/profile_page.dart';
import '../ui/schedule_page.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() {
    // ignore: prefer_const_constructors
    return [HomePage(), const DiscoverPage(), const SchedulePage(), const ProfilePage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/icons/home.png",
          color: const Color.fromARGB(255, 96, 39, 176),
        ),
        activeColorPrimary: purpleColor,
        inactiveIcon: Image.asset("assets/icons/home.png"),
        title: ("Home"),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/icons/discover.png",
          color: const Color.fromARGB(255, 96, 39, 176),
        ),
        activeColorPrimary: purpleColor,
        inactiveIcon: Image.asset(
          "assets/icons/discover.png",
        ),
        title: ("Discover"),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/icons/meeting.png",
          color: const Color.fromARGB(255, 96, 39, 176),
        ),
        activeColorPrimary: purpleColor,
        inactiveIcon: Image.asset(
          "assets/icons/meeting.png",
        ),
        title: ("Schedule"),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/icons/profile.png",
          color: const Color.fromARGB(255, 96, 39, 176),
        ),
        inactiveIcon: Image.asset(
          "assets/icons/profile.png",
        ),
        activeColorPrimary: purpleColor,
        title: ("Profile"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12,
    );
  }
}
