

class Permit {


  int PermitLicenceID;
  int DriverID;
  String PermitNumber;
  String PhotoURL;
  String Code;
  String Place;

  Permit({
    this.PermitLicenceID,
    this.DriverID,
    this.PermitNumber,
    this.PhotoURL,
    this.Code,
    this.Place
  });

  factory Permit.fromJson(Map<String, dynamic> parsedJson){
    return Permit(
        PermitLicenceID: parsedJson['PermitLicenceID'],
        DriverID : parsedJson['DriverID'],
        PermitNumber : parsedJson ['PermitNumber'],
        PhotoURL : parsedJson['PhotoURL'],
      Code : parsedJson['Code'],
      Place : parsedJson['Place'],
    );
  }

  Map<String, dynamic> toJsonAttr() => {
    'PermitLicenceID': PermitLicenceID,
    'DriverID': DriverID,
    'PermitNumber': PermitNumber,
    'PhotoURL': PhotoURL,
    'Code': Code,
    'Place': Place,
  };

}