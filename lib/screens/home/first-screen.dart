import 'dart:convert';

import 'package:naqelapp/session/DecodeToken.dart';
import 'package:naqelapp/session/Trailer.dart';
import 'package:naqelapp/session/Trucks.dart';
import 'package:naqelapp/session/Userprofile.dart';
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

  Map<String, dynamic> parseJwt(String token) {

    final parts = token.split('.');
    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }




  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }



}

