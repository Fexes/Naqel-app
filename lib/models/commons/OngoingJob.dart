
 

class OngoingJob {

  int CompletedByDriver;
  int CompletedByTrader;
  String Created;
  String JobNumber;
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
    this.JobNumber,
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
      JobNumber : parsedJson['JobNumber'],
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


}

  