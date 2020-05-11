import 'dart:convert';
import 'dart:io';

import 'package:naqelapp/models/jobs/CompletedJob.dart';
import 'package:naqelapp/models/jobs/JobOfferPosts.dart';
import 'package:naqelapp/models/jobs/JobRequests.dart';
import 'package:naqelapp/models/Permit.dart';
import 'package:naqelapp/models/Trailer.dart';
import 'package:naqelapp/models/Trucks.dart';
import 'package:naqelapp/models/DriverProfile.dart';
import 'package:naqelapp/models/documents/DrivingLicence.dart';
import 'package:naqelapp/models/documents/EntryExitCard.dart';
import 'package:naqelapp/models/documents/IdentityCard.dart';
import 'package:naqelapp/models/jobs/OngoingJob.dart';

import 'UI/toast_utility.dart';
import 'URLs.dart';

class DataStream{
  static String token;
  static DriverProfile driverProfile;
  static Trucks truck;

  static List<Trailer> trailers;
  static List<Permit> permit;
  static List<JobRequests> requests;
  static List<JobOfferPosts> joboffersposts;
  static List<CompletedJobPackages> compleatedJobspackage;

  static OngoingJob ongoingJob;

  static EntryExitCard entryExitCard;
  static IdentityCard identityCard;
  static DrivingLicence drivingLicence;

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

  static List<JobOfferPosts> parseJobOffer(requestsJson){
    var list = requestsJson as List;
    List<JobOfferPosts> offers= list.map((data) => JobOfferPosts.fromJson(data)).toList();
    return offers;

  }

  static List<CompletedJobPackages> parseCompletedJobs(requestsJson){
    var list = requestsJson as List;
    List<CompletedJobPackages> offers= list.map((data) => CompletedJobPackages.fromJson(data)).toList();
    return offers;

  }
}
