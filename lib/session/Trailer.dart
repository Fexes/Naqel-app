

class Trailer {


  int TruckID;
  int MaximumWeight;
  String TrailerPhotoURL;
  String Type;

  Trailer({
    this.TruckID,
    this.MaximumWeight,
    this.TrailerPhotoURL,
    this.Type
  });

  factory Trailer.fromJson(Map<String, dynamic> parsedJson){
    return Trailer(
        TruckID: parsedJson['TrailerID'],
        MaximumWeight : parsedJson['MaximumWeight'],
        TrailerPhotoURL : parsedJson ['PhotoURL'],
        Type : parsedJson['Type']
    );
  }

}