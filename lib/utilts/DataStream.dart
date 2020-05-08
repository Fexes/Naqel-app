import 'dart:convert';
import 'dart:io';

import 'package:naqelapp/models/JobRequests.dart';
import 'package:naqelapp/models/Permit.dart';
import 'package:naqelapp/models/Trailer.dart';
import 'package:naqelapp/models/Trucks.dart';
import 'package:naqelapp/models/DriverProfile.dart';

import 'UI/toast_utility.dart';
import 'URLs.dart';

class DataStream{
  static String token;
  static DriverProfile userdata;
  static Trucks truck;

  static List<Trailer> trailers;
  static List<Permit> permit;
  static List<JobRequests> requests;



  static List<Trailer> parseTrailer(trailerJson){
    var list = trailerJson as List;
    List<Trailer> trailers= list.map((data) => Trailer.fromJson(data)).toList();
    return trailers;

  }
  static List<Permit> parsePermit(permitJson){
    var list = permitJson as List;
    List<Permit> permit= list.map((data) => Permit.fromJson(data)).toList();
    return permit;

  }
  static List<JobRequests> parseRequests(requestsJson){
    var list = requestsJson as List;
    List<JobRequests> requests= list.map((data) => JobRequests.fromJson(data)).toList();
    return requests;

  }

}
