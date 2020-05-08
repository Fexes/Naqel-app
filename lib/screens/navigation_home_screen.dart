import 'package:naqelapp/styles/app_theme.dart';
import 'package:naqelapp/custom_drawer/drawer_user_controller.dart';
import 'package:naqelapp/custom_drawer/driver_drawer.dart';
import 'package:naqelapp/screens/home/jobs_screen.dart';

import 'package:flutter/material.dart';

import 'home/permits_page.dart';
import 'home/profile_screen.dart';
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
         screenView = const TruckPage();
        });
      }
      else if (drawerIndex == DrawerIndex.PERMITS) {
        setState(() {
          screenView = const PermitPage();
        });
      }

      else {
        //do in your way......
      }
    }
  }
}

