
class JobOfferPosts {

   JobOffer jobOffer;
   Trader trader;
   DriverRequest driverRequest;


  JobOfferPosts({
    this.jobOffer,
     this.trader,
     this.driverRequest
  });

  factory JobOfferPosts.fromJson(Map<String, dynamic> parsedJson){
    return JobOfferPosts(
      jobOffer: JobOffer.fromJson(parsedJson["JobOffer"]),
      trader : Trader.fromJson(parsedJson["Trader"]),
      driverRequest : DriverRequest.fromJson(parsedJson["DriverRequest"]),
    );
  }

  Map<String, dynamic> toJsonAttr() => {
    'jobOffer': jobOffer,
    'Trader': trader,
    'DriverRequest': driverRequest,

  };


}

class JobOffer {


  int JobOfferID;
  int TraderID;
  String LoadingPlace;
  String UnloadingPlace;
  String TripType;
  int Price;
  int WaitingTime;
  String TimeCreated;
  String CargoType;
  int CargoWeight;
  String LoadingLocation;
  String UnloadingLocation;
  String LoadingDate;
  String LoadingTime;
  String TruckModel;
  String DriverNationality;
  int EntryExit;
  int AcceptedDelay;
  String JobOfferType;


  JobOffer({
    this.JobOfferID,
    this.TraderID,
    this.LoadingPlace,
    this.UnloadingPlace,
    this.TripType,
    this.Price,
    this.WaitingTime,
    this.TimeCreated,
    this. CargoType,
    this.CargoWeight,
    this. LoadingLocation,
    this. UnloadingLocation,
    this. LoadingDate,
    this. LoadingTime,
    this. TruckModel,
    this. DriverNationality,
    this.EntryExit,
    this.AcceptedDelay,
    this. JobOfferType,
  });

  factory JobOffer.fromJson(Map<String, dynamic> parsedJson){
    return JobOffer(
      JobOfferID: parsedJson['JobOfferID'],
      TraderID : parsedJson['TraderID'],
      LoadingPlace : parsedJson ['LoadingPlace'],
      UnloadingPlace : parsedJson['UnloadingPlace'],
      TripType : parsedJson['TripType'],
      Price : parsedJson['Price'],
      WaitingTime : parsedJson['WaitingTime'],
      TimeCreated : parsedJson['TimeCreated'],
      CargoType: parsedJson['CargoType'],
      CargoWeight : parsedJson['CargoWeight'],
      LoadingLocation : parsedJson ['LoadingLocation'],
      UnloadingLocation : parsedJson['UnloadingLocation'],
      LoadingDate : parsedJson['LoadingDate'],
      LoadingTime : parsedJson['LoadingTime'],
      TruckModel : parsedJson['TruckModel'],
      DriverNationality : parsedJson['DriverNationality'],
      EntryExit : parsedJson['EntryExit'],
      AcceptedDelay : parsedJson['AcceptedDelay'],
      JobOfferType : parsedJson['JobOfferType'],
    );
  }

  Map<String, dynamic> toJsonAttr() => {
    'JobOfferID': JobOfferID,
    'TraderID': TraderID,
    'LoadingPlace': LoadingPlace,
    'UnloadingPlace': UnloadingPlace,
    'TripType': TripType,
    'Price': Price,
    'WaitingTime' : WaitingTime,
    'TimeCreated' : TimeCreated,
    'CargoType': CargoType,
    'CargoWeight': CargoWeight,
    'LoadingLocation': LoadingLocation,
    'UnloadingLocation': UnloadingLocation,
    'TripTLoadingDateype': LoadingDate,
    'LoadingTime': LoadingTime,
    'TruckModel' : TruckModel,
    'DriverNationality' : DriverNationality,
    'EntryExit': EntryExit,
    'AcceptedDelay' : AcceptedDelay,
    'JobOfferType' : JobOfferType,
  };
}

class Trader {
  String FirstName;
  String LastName;

  Trader({
    this.FirstName,
    this.LastName,

  });
  factory Trader.fromJson(Map<String, dynamic> parsedJson){
    return Trader(
      FirstName : parsedJson['FirstName'],
      LastName : parsedJson ['LastName'],
    );
  }

  Map<String, dynamic> toJsonAttr() => {
     'FirstName': FirstName,
    'LastName': LastName,

  };
}

class DriverRequest {
  int DriverRequestID;
  int DriverID;
  int JobOfferID;
  int Price;
  String Created;


  DriverRequest({
    this.DriverRequestID,
    this.DriverID,
    this.JobOfferID,
    this.Price,
    this.Created,
  });
  factory DriverRequest.fromJson(Map<String, dynamic> parsedJson){
    if(parsedJson!=null) {
      return DriverRequest(
        DriverRequestID: parsedJson['DriverRequestID'],
        DriverID: parsedJson ['DriverID'],
        JobOfferID: parsedJson['JobOfferID'],
        Price: parsedJson ['Price'],
        Created: parsedJson['Created'],
      );
    }else{
      return null;
    }
  }

  Map<String, dynamic> toJsonAttr() => {
    'DriverRequestID': DriverRequestID,
    'DriverID': DriverID,
    'JobOfferID': JobOfferID,
    'DriverID': DriverID,
    'Price': Price,
    'Created': Created,

  };
}