

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/Permit.dart';
import '../models/Trailer.dart';
import '../models/Trucks.dart';
import '../models/DriverProfile.dart';

class DecodeToken{

  static bool DecodeSuccess=false;

  int DriverID=0;
  String Username="";
  String Password="";
  String PhoneNumber="";
  String FirstName="";
  String LastName="";
  String Nationality="";
  String Email="";
  String Gender="";
  String DateOfBirth="";
  String Address="";
  String PhotoURL="";
  int Active=0;


  int TruckID =0;
  int TransportCompanyID =0;
  String PlateNumber="";
  String Owner="";
  int ProductionYear=0;
  String Brand="";
  String Model="";
  String Type="";
  int MaximumWeight=0;
  String TruckPhotoURL="";

  List Trailers=null;
  List Permits=null;
  List Requests=null;

  String UserToken="";


  DecodeToken(String token){
    process(token);
  }

  Future<void> process(String token)  async {
    print(token);

    Map<String,dynamic> attributeMap = new Map<String,dynamic>();
    attributeMap=parseJwt(token);
    print(attributeMap);


    UserToken=token;

    DriverID = attributeMap['DriverID'] ;
    PhotoURL =  attributeMap["PhotoURL"] ;
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


      Map<String, dynamic> TrucksMap = new Map<String, dynamic>.from(attributeMap["Truck"]);

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



    }

     addData(await SharedPreferences.getInstance());

  }

  void addData(SharedPreferences prefs) {



    prefs.setString('UserToken', UserToken);







    if(FirstName==""||LastName==""||Nationality==""||Address==""||Gender==""||PhotoURL=="") {
     // DriverProfile.setComplete(true);
    }else{
     // DriverProfile.setComplete(false);
    }

    if(Owner==""||PlateNumber==""||ProductionYear==""||Brand==""||Model==""||Type==""||MaximumWeight==""||TruckPhotoURL=="") {
     // Trucks.setComplete(true);
    }else{
     // Trucks.setComplete(false);
    }

  }

  Map<String, dynamic> parseJwt(String token) {

     final payload = token;

    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }



}

