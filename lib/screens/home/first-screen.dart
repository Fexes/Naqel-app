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
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();

    DriverID = prefs.getInt('DriverID');
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

    new Timer(Duration(seconds: 1), onDoneLoading(Username));


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

/*

      Trucks.setTransportCompanyID(TransportCompanyID);
      Trucks.setPlateNumber(PlateNumber);
      Trucks.setOwner(Owner);
      Trucks.setProductionYear(ProductionYear);
      Trucks.setBrand(Brand);
      Trucks.setModel(Model);
      Trucks.setType(Type);
      Trucks.setMaximumWeight(MaximumWeight);
      Trucks.setTruckPhotoURL(TruckPhotoURL);

*/

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

