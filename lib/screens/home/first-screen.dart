import 'dart:convert';

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
  int DriverID ;
  String Username ;
  String Password ;
  String PhoneNumber ;
  String FirstName ;
  String LastName ;
  String Nationality;
  String Email ;
  String Gender  ;
  String DateOfBirth ;
  String Address ,ProfilePhotoURL;
  int Active;

  int TruckID ;
  int TransportCompanyID;
  String PlateNumber;
  String Owner;
  int ProductionYear;
  String Brand;
  String Model;
  String Type;
  int MaximumWeight;
  String TruckPhotoURL;
  String UserToken;
  List<Trailer> Trailers;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserToken =prefs.getString("UserToken");



    /*   DriverID = prefs.getInt('DriverID');
    Username = prefs.getString('Username');
    Password = prefs.getString('Password');
    PhoneNumber =  prefs.getString('PhoneNumber');
    FirstName = prefs.getString('FirstName');
    LastName = prefs.getString('LastName');
    Nationality = prefs.getString('Nationality');
    Email =  prefs.getString('Email');
    Gender =  prefs.getString('Gender');
    DateOfBirth =  prefs.getString('DateOfBirth');
    Address =  prefs.getString('Address');
    Active =  prefs.getInt('Active');
    ProfilePhotoURL =prefs.getString("ProfilePhotoURL");



    TruckID = prefs.getInt('TruckID');
    TransportCompanyID = prefs.getInt('TransportCompanyID');
    PlateNumber = prefs.getString('PlateNumber');
    Owner = prefs.getString('Owner');
    ProductionYear =  prefs.getInt('ProductionYear');
    Brand =  prefs.getString('Brand');
    Model =  prefs.getString('Model');
    Type =  prefs.getString('Type');
    MaximumWeight =  prefs.getInt('MaximumWeight');
    TruckPhotoURL =prefs.getString("TruckPhotoURL");
    */




    if(UserToken==null||UserToken ==""){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));

    }else{
      Map<String,dynamic> attributeMap = new Map<String,dynamic>();
      print(UserToken);
      attributeMap=parseJwt(UserToken);

      // print(attributeMap);

      DriverID = attributeMap['DriverID'] ;
      ProfilePhotoURL =  attributeMap["ProfilePhotoURL"] ;
      Username = attributeMap["Username"] ;
      Password = attributeMap["Password"] ;
      PhoneNumber = attributeMap["PhoneNumber"] ;
      FirstName = attributeMap["FirstName"] ;
      LastName = attributeMap["LastName"] ;
      Nationality = attributeMap["Nationality"] ;
      Email = attributeMap["Email"] ;
      Gender = attributeMap["Gender"] ;
      DateOfBirth = attributeMap["DateOfBirth"] ;
      Address = attributeMap["Address"] ;
      Active = attributeMap['Active'] ;



      if(attributeMap["Truck"]!=null) {
        //    print(attributeMap["Truck"]);


        Map<String, dynamic> TrucksMap = new Map<String, dynamic>.from(
            attributeMap["Truck"]);

        TruckID = TrucksMap['TruckID'];
        TransportCompanyID = TrucksMap['TransportCompanyID'];
        PlateNumber = TrucksMap["PlateNumber"];
        Owner = TrucksMap["Owner"];
        ProductionYear = TrucksMap['ProductionYear'];
        Brand = TrucksMap["Brand"];
        Model = TrucksMap["Model"];
        Type = TrucksMap["Type"];
        MaximumWeight = TrucksMap['MaximumWeight'];
        TruckPhotoURL = TrucksMap["PhotoURL"];


        Trucks truck = new Trucks.fromJson(attributeMap["Truck"]);

        Trailers = truck.Trailers;
        onDoneLoading(Username);
    }

   //   new Timer(Duration(seconds: 1), onDoneLoading(Username));
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


  onDoneLoading(String name) async {



    if(name==null||name ==""){

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));

    }else{

      Userprofile.setDriverID(DriverID);
      Userprofile.setProfileImage(ProfilePhotoURL);
      Userprofile.setUsername(Username);
      Userprofile.setPassword(Password);
      Userprofile.setPhoneNumber(PhoneNumber);
      Userprofile.setFirstName(FirstName);
      Userprofile.setLastName(LastName);
      Userprofile.setNationality(Nationality);
      Userprofile.setEmail(Email);
      Userprofile.setGender(Gender);
      Userprofile.setDateOfBirth(DateOfBirth);
      Userprofile.setAddress(Address);
      Userprofile.setActive(Active);

      Userprofile.setUserToken(UserToken);


      Trucks.setTransportCompanyID(TransportCompanyID);
      Trucks.setPlateNumber(PlateNumber);
      Trucks.setOwner(Owner);
      Trucks.setProductionYear(ProductionYear);
      Trucks.setBrand(Brand);
      Trucks.setModel(Model);
      Trucks.setType(Type);
      Trucks.setMaximumWeight(MaximumWeight);
      Trucks.setTruckPhotoURL(TruckPhotoURL);
      Trucks.setAllTrailers(Trailers);



      if(FirstName==""||LastName==""||Nationality==""||Address==""||Gender=="") {
        Userprofile.setComplete(true);
      }else{
        Userprofile.setComplete(false);
      }


      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavigationHomeScreen()));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }



}

