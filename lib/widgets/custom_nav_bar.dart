import 'package:flutter/material.dart';
import 'package:mentoru/ui/home/discover_page.dart';
import 'package:mentoru/ui/home/home_page.dart';
import 'package:mentoru/ui/home/profile_page.dart';
import 'package:mentoru/ui/home/schedule_page.dart';
import 'package:mentoru/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomNavBar extends StatefulWidget {
  CustomNavBar({super.key});

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
    return [HomePage(), DiscoverPage(), SchedulePage(), ProfilePage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/icons/home.png",
          color: Color.fromARGB(255, 96, 39, 176),
        ),
        activeColorPrimary: purpleColor,
        inactiveIcon: Image.asset("assets/icons/home.png"),
        title: ("Home"),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/icons/discover.png",
          color: Color.fromARGB(255, 96, 39, 176),
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
          color: Color.fromARGB(255, 96, 39, 176),
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
          color: Color.fromARGB(255, 96, 39, 176),
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
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12,
    );
  }
}
