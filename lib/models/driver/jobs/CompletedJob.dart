class CompletedJobPackages{


  CompletedJob completedJob;
  DriverReview driverReview;


  CompletedJobPackages({
    this.completedJob,
    this.driverReview,
   });

  factory CompletedJobPackages.fromJson(Map<String, dynamic> parsedJson){
    return CompletedJobPackages(
      completedJob: CompletedJob.fromJson(parsedJson["CompletedJob"]),
      driverReview : DriverReview.fromJson(parsedJson["DriverReview"]),
     );
  }

  Map<String, dynamic> toJsonAttr() => {
    'completedJob': completedJob,
    'driverReview': driverReview,

  };
}
class CompletedJob {
  int CompletedJobID;
  int DriverID;
  int TraderID;
  String TripType;
  String CargoType;
  int CargoWeight;
  String LoadingPlace;
  String UnloadingPlace;
  String LoadingDate;
  String LoadingTime;
  int EntryExit;
  int AcceptedDelay;
  int Price;
  String Created;

  CompletedJob({
    this.CompletedJobID,
    this.DriverID,
    this.TraderID,
    this.TripType,
    this.CargoType,
    this.CargoWeight,
    this.LoadingPlace,
    this.UnloadingPlace,
    this.LoadingDate,
    this.LoadingTime,
    this.EntryExit,
    this.AcceptedDelay,
    this.Price,
    this.Created,
  });

  factory CompletedJob.fromJson(Map<String, dynamic> parsedJson){
    return CompletedJob(
      CompletedJobID: parsedJson['CompletedJobID'],
      DriverID: parsedJson['DriverID'],
      TraderID: parsedJson['TraderID'],
      TripType: parsedJson['TripType'],
      CargoType: parsedJson['CargoType'],
      CargoWeight: parsedJson['CargoWeight'],
      LoadingPlace: parsedJson['LoadingPlace'],
      UnloadingPlace: parsedJson['UnloadingPlace'],
      LoadingDate: parsedJson['LoadingDate'],
      LoadingTime: parsedJson['LoadingTime'],
      EntryExit: parsedJson['EntryExit'],
      AcceptedDelay: parsedJson['AcceptedDelay'],
      Price: parsedJson['Price'],
      Created: parsedJson['Created'],

    );
  }

  Map<String, dynamic> toJsonAttr() => {
    'CompletedJobID': CompletedJobID,
    'DriverID': DriverID,
    'TraderID': TraderID,
    'TripType': TripType,
    'CargoType': CargoType,
    'CargoWeight': CargoWeight,
    'LoadingPlace': LoadingPlace,
    'UnloadingPlace': UnloadingPlace,
    'LoadingDate': LoadingDate,
    'LoadingTime': LoadingTime,
    'EntryExit': EntryExit,
    'AcceptedDelay': AcceptedDelay,
    'Price': Price,
    'Created': Created,

  };

}
class DriverReview {
  int DriverReviewID;
  int CompletedJobID;
  int DriverID;
  int TraderID;
  String Review;
  int Rating;
  String Created;

  DriverReview({
    this.CompletedJobID,
    this.DriverID,
    this.TraderID,
    this.Review,
    this.Rating,
    this.Created,
  });

  factory DriverReview.fromJson(Map<String, dynamic> parsedJson){
    return DriverReview(
      CompletedJobID: parsedJson['CompletedJobID'],
      DriverID: parsedJson['DriverID'],
      TraderID: parsedJson['TraderID'],
      Created: parsedJson['Created'],
      Review: parsedJson['Review'],
      Rating: parsedJson['Rating'],

    );
  }

  Map<String, dynamic> toJsonAttr() => {
    'CompletedJobID': CompletedJobID,
    'DriverID': DriverID,
    'TraderID': TraderID,
    'Created': Created,
    'Review': Review,
    'Rating': Rating,
  };
}