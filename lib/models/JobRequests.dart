class JobRequests {

  int JobRequestID;
  int DriverID;
  String LoadingPlace;
  String UnloadingPlace;
  String TripType;
  int Price;
  int WaitingTime;
  String TimeCreated;

  JobRequests({
    this.JobRequestID,
    this.DriverID,
    this.LoadingPlace,
    this.UnloadingPlace,
    this.TripType,
    this.Price,
    this.WaitingTime,
    this.TimeCreated
  });

  factory JobRequests.fromJson(Map<String, dynamic> parsedJson){
    return JobRequests(
        JobRequestID: parsedJson['JobRequestID'],
        DriverID : parsedJson['DriverID'],
        LoadingPlace : parsedJson ['LoadingPlace'],
        UnloadingPlace : parsedJson['UnloadingPlace'],
        TripType : parsedJson['TripType'],
        Price : parsedJson['Price'],
        WaitingTime : parsedJson['WaitingTime'],
        TimeCreated : parsedJson['TimeCreated']

    );
  }

  Map<String, dynamic> toJsonAttr() => {
    'JobRequestID': JobRequestID,
    'DriverID': DriverID,
    'LoadingPlace': LoadingPlace,
    'UnloadingPlace': UnloadingPlace,
    'TripType': TripType,
    'Price': Price,
    'WaitingTime' : WaitingTime,
    'TimeCreated' : TimeCreated,

  };
}