import 'dart:convert';

import 'package:naqelapp/session/DecodeToken.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../navigation_home_screen.dart';
import '../auth/sign-in.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  String UserToken;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserToken =prefs.getString("UserToken");


    if(UserToken==null||UserToken ==""){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));

    }else{

      print(UserToken);
      DecodeToken(UserToken);


      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavigationHomeScreen()));


     }
}






  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }



}

