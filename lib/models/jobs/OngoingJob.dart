
 

class OngoingJob {

  int CompletedByDriver;
  int CompletedByTrader;
  String Created;
  int  DriverID;
  
  int OnGoingJobID;
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


  OngoingJob({
    this.CompletedByDriver,
    this.CompletedByTrader,
    this.Created,
    this.DriverID,

    this.OnGoingJobID,
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

  factory OngoingJob.fromJson(Map<String, dynamic> parsedJson){
    return OngoingJob(
      CompletedByDriver: parsedJson['CompletedByDriver'],
      CompletedByTrader : parsedJson['CompletedByTrader'],
      Created : parsedJson ['Created'],
      DriverID : parsedJson['DriverID'],

      OnGoingJobID: parsedJson['OnGoingJobID'],
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
    'CompletedByDriver': CompletedByDriver,
    'CompletedByTrader': CompletedByTrader,
    'Created': Created,
    'DriverID': DriverID,

    'OnGoingJobID': OnGoingJobID,
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

  