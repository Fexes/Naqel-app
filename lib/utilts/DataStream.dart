import 'dart:convert';
import 'dart:io';

import 'package:naqelapp/models/driver/Permit.dart';
import 'package:naqelapp/models/driver/documents/IdentityCard.dart';
import 'package:naqelapp/models/driver/jobs/CompletedJob.dart';
import 'package:naqelapp/models/driver/jobs/JobOfferPosts.dart';
import 'package:naqelapp/models/driver/jobs/JobRequests.dart';
import 'package:naqelapp/models/driver/Trailer.dart';
import 'package:naqelapp/models/driver/Trucks.dart';
import 'package:naqelapp/models/driver/DriverProfile.dart';
import 'package:naqelapp/models/driver/documents/DrivingLicence.dart';
import 'package:naqelapp/models/driver/documents/EntryExitCard.dart';
 import 'package:naqelapp/models/driver/jobs/OngoingJob.dart';
import 'package:naqelapp/models/trader/TraderProfile.dart';
import 'package:naqelapp/models/trader/documents/CommercialRegisterCertificate.dart';
import 'package:naqelapp/models/trader/documents/TraderIdentityCard.dart';

import 'UI/toast_utility.dart';
import 'URLs.dart';

class DataStream{
  static String token;
  static DriverProfile driverProfile;
  static TraderProfile traderProfile;
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
  static TraderIdentityCard traderIdentityCard;
  static CommercialRegisterCertificate commercialRegisterCertificate;

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
