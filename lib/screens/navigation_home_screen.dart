import 'package:naqelapp/styles/app_theme.dart';
import 'package:naqelapp/custom_drawer/drawer_user_controller.dart';
import 'package:naqelapp/custom_drawer/home_drawer.dart';
import 'package:naqelapp/screens/home/home_screen.dart';
import 'package:naqelapp/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';

import 'home/trucks_screen.dart';


class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
 // AnimationController sliderAnimationController;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,

            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.ACCOUNT) {
        setState(() {
          screenView = const MyProfilePage();

        });
      }
      else if (drawerIndex == DrawerIndex.TRUCK) {
        setState(() {
         screenView = TruckPage();
        });
      }


      else {
        //do in your way......
      }
    }
  }
}
