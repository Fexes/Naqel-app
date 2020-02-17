

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

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
  String UserToken="";

  var Trailersjson="";

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
          Trailer trailer = truck.Trailers[0];


          Trailersjson =
              jsonEncode(Trailers, toEncodable: (e) => trailer.toJsonAttr());
     }



    }
    addData(await SharedPreferences.getInstance());

  }

  void addData(SharedPreferences prefs) {

    prefs.setInt('DriverID',DriverID);
    prefs.setString('Username', Username);
    prefs.setString('ProfilePhotoURL', ProfilePhotoURL);
    prefs.setString('Password', Password);
    prefs.setString('PhoneNumber', PhoneNumber);
    prefs.setString('FirstName', FirstName);
    prefs.setString('LastName',LastName);
    prefs.setString('Nationality', Nationality);
    prefs.setString('Email', Email);
    prefs.setString('Gender', Gender);
    prefs.setString('DateOfBirth', DateOfBirth);
    prefs.setString('Address',Address);
    prefs.setInt('Active', Active);


    prefs.setString('UserToken', UserToken);


    prefs.setInt('TransportCompanyID', TransportCompanyID);
    prefs.setString('PlateNumber', PlateNumber);
    prefs.setString('Owner', Owner);
    prefs.setInt('ProductionYear', ProductionYear);
    prefs.setString('Brand', Brand);
    prefs.setString('Model',Model);
    prefs.setString('Type', Model);
    prefs.setInt('MaximumWeight', MaximumWeight);
    prefs.setString('TruckPhotoURL', TruckPhotoURL);

    prefs.setString('Trailers', Trailersjson);



    Trucks.setTransportCompanyID(TransportCompanyID);
    Trucks.setPlateNumber(PlateNumber);
    Trucks.setOwner(Owner);
    Trucks.setProductionYear(ProductionYear);
    Trucks.setBrand(Brand);
    Trucks.setModel(Model);
    Trucks.setType(Model);
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

