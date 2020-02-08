

import 'Trailer.dart';

class Trucks {


  static int DriverID;
  static int TruckID;
  static int TransportCompanyID;
  static String PlateNumber;
  static String Owner;
  static int ProductionYear;
  static String Brand;
  static String Model;
  static String Type;
  static int MaximumWeight;
  static String TruckPhotoURL;
  static bool Complete;



  static void setComplete(bool data){
    Complete=data;
  }
  static void setDriverID(int data){
    DriverID=data;
  }
  static void setTruckID(int data){
    TruckID=data;
  }
  static void setTransportCompanyID(int data){
    TransportCompanyID=data;
  }
  static void setPlateNumber(String data){
    PlateNumber=data;
  }
  static void setOwner(String data){
    Owner=data;
  }
  static void setProductionYear(int data){
    ProductionYear=data;
  }
  static void setBrand(String data){
    Brand=data;
  }
  static void setModel(String data){
    Model=data;
  }
  static void setType(String data){
    Type=data;
  }
  static void setMaximumWeight(int data){
    MaximumWeight=data;
  }
  static void setTruckPhotoURL(String data){
    TruckPhotoURL=data;
  }


  static bool isComplete(){
    return Complete;
  }

  static int getDriverID(){
    return DriverID;
  }
  static int getTruckID(){
    return TruckID;
  }
  static int getTransportCompanyID(){
    return TransportCompanyID;
  }

  static String getPlateNumber(){
    return PlateNumber;
  }

  static String getOwner(){
    return Owner;
  }
  static int getProductionYear(){
    return ProductionYear;
  }
  static String getBrand(){
    return Brand;
  }
  static String getModel(){
    return Model;
  }
  static String getType(){
    return Type;
  }
  static int getMaximumWeight(){
    return MaximumWeight;
  }
  static String getTruckPhotoURL(){
    return TruckPhotoURL;
  }



   List<Trailer> Trailers;

  Trucks({

    this.Trailers
  });

   factory Trucks.fromJson(Map<String, dynamic> parsedJson){
     return Trucks(
         Trailers : parseTrailer(parsedJson['Trailers'])

     );
   }

   static List<Trailer> parseTrailer(trailerJson){
     var list = trailerJson as List;
     List<Trailer> trailers= list.map((data) => Trailer.fromJson(data)).toList();
     return trailers;

   }


}
