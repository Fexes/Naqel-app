

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'Permit.dart';
import 'Trailer.dart';
import 'Trucks.dart';
import 'Userprofile.dart';

class DecodeToken{

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
  String ProfilePhotoURL="";
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

  String UserToken="";


  DecodeToken(String token){
    process(token);
  }

  Future<void> process(String token)  async {

    Map<String,dynamic> attributeMap = new Map<String,dynamic>();
    attributeMap=parseJwt(token);
    print(attributeMap);




    UserToken=token;

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

     if(truck.Trailers.length>0) {
          Trailers = truck.Trailers;

     }

    }


    if(attributeMap["PermitLicences"]!=null) {
      print(attributeMap["PermitLicences"]);

      Userprofile permit = new Userprofile.PermitsfromJson(attributeMap);

      if(permit.Permits.length>0) {

        Permits = permit.Permits;

      }



      if(attributeMap["IdentityCard"]!=null) {
        //  print(attributeMap["IdentityCard"]);
        Map<String, dynamic> IdentityCard = new Map<String, dynamic>.from(attributeMap["IdentityCard"]);
        //  print(DrivingLicence["IDNumber"]);

      }
      //EntryExitCard
      if(attributeMap["EntryExitCard"]!=null) {
        //   print(attributeMap["EntryExitCard"]);
        Map<String, dynamic> EntryExitCard = new Map<String, dynamic>.from(attributeMap["EntryExitCard"]);
        //  print(DrivingLicence["IDNumber"]);

      }
      //DrivingLicence
      if(attributeMap["DrivingLicence"]!=null) {
        //  print(attributeMap["DrivingLicence"]);
        Map<String, dynamic> DrivingLicence = new Map<String, dynamic>.from(attributeMap["DrivingLicence"]);

      }

      //   Map<String, dynamic> PermitLicences = new Map<String, dynamic>.from(attributeMap["PermitLicences"]);
      //  print(DrivingLicence["IDNumber"]);

    }
    addData(await SharedPreferences.getInstance());

  }

  void addData(SharedPreferences prefs) {



    prefs.setString('UserToken', UserToken);





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

    Userprofile.setUserToken(UserToken);


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
    Userprofile.setPermits(Permits);



    if(FirstName==""||LastName==""||Nationality==""||Address==""||Gender=="") {
      Userprofile.setComplete(true);
    }else{
      Userprofile.setComplete(false);
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

}

