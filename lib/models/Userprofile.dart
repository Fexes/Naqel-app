
import 'package:naqelapp/models/JobRequests.dart';

import 'Permit.dart';


class Userprofile {

  static int DriverID;
  static String Username;
  static String Password;
  static String PhoneNumber;
  static String FirstName;
  static String LastName;
  static String Nationality;
  static String Email;
  static String Gender;
  static String DateOfBirth;
  static String Address;
  static String ProfilePhotoURL;
  static String UserToken;
  static int Active;
  static bool Complete;
  static List<Permit> AllPermits;
  static List<JobRequests> AllJobRequests;




  static void setComplete(bool data){
    Complete=data;
  }
  static void setPermits(List<Permit> data){
    AllPermits=data;
  }
   static void setJobRequests(List<JobRequests> data){
    AllJobRequests=data;
  }
  static void setProfileImage(String data){
    ProfilePhotoURL=data;
  }
  static void setDriverID(int data){
    DriverID=data;
  }
  static void setUsername(String data){
    Username=data;
  }
  static void setPassword(String data){
    Password=data;
  }
  static void setPhoneNumber(String data){
    PhoneNumber=data;
  }
  static void setFirstName(String data){
    FirstName=data;
  }
  static void setLastName(String data){
    LastName=data;
  }
  static void setNationality(String data){
    Nationality=data;
  }
  static void setEmail(String data){
    Email=data;
  }
  static void setGender(String data){
    Gender=data;
  }
  static void setDateOfBirth(String data){
    DateOfBirth=data;
  }
  static void setAddress(String data){
    Address=data;
  }
  static void setActive(int data){
    Active=data;
  }
  //

  static void setUserToken(String data){
    UserToken=data;
  }

  static int getDriverID(){
    return DriverID;
  }

  static String getProfileImage(){
    return ProfilePhotoURL;
  }


  static String getUserToken(){
    return UserToken;
  }

  static String getUsername(){
    return Username;
  }

  static String getPassword(){
    return Password;
  }
  static String getPhoneNumber(){
    return PhoneNumber;
  }
  static String getFirstName(){
    return FirstName;
  }
  static String getLastName(){
    return LastName;
  }
  static String getNationality(){
    return Nationality;
  }
  static String getEmail(){
    return Email;
  }
  static String getGender(){
    return Gender;
  }
  static String getDateOfBirth(){
    return DateOfBirth;
  }
  static String getAddress(){
    return Address;
  }
  static int getActive(){
    return Active;
  }
  static List<Permit> getPermit(){
    return AllPermits;
  }
  static List<JobRequests> getJobRequests(){
    return AllJobRequests;
  }
  //AllJobRequests
  static bool isComplete(){
    return Complete;
  }


 List<Permit> Permits;
 List<JobRequests> Requests;

  Userprofile({
    this.Permits,
    this.Requests
  });

  factory Userprofile.DatafromJson(Map<String, dynamic> parsedJson){
    return Userprofile(
        Permits : parsePermit(parsedJson['PermitLicences']),
        Requests : parseJobRequests(parsedJson['JobRequests'])

    );
  }

  static List<JobRequests> parseJobRequests(trailerJson){
    var list = trailerJson as List;
    List<JobRequests> data= list.map((data) => JobRequests.fromJson(data)).toList();
    return data;

  }
  static List<Permit> parsePermit(trailerJson){
    var list = trailerJson as List;
    List<Permit> permts= list.map((data) => Permit.fromJson(data)).toList();
    return permts;

  }
}