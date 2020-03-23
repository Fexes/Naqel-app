

class URLs{

  static String BaseURL = "https://naqelserver.azurewebsites.net";
//************** User Auth *************

  static String loginUrl(){
    return "$BaseURL/drivers/login";
  }
  static String registercheckUrl(){
    return "$BaseURL/drivers/register";
  }
  static String signUpUrl(){
    return "$BaseURL/drivers/accountSetup";
  }
  static String generalSettingUrl(){
    return "$BaseURL/drivers/generalSettings";
  }
  static String emailSettingUrl(){
    return "$BaseURL/drivers/usernameAndEmailSettings";
  }
  static String passwordSettingUrl(){
    return "$BaseURL/drivers/passwordSettings";
  }
  static String updatePhotoUrlInDatabase(){
    return "$BaseURL/drivers/uploadDriverProfilePhoto";
  }

  //************** Trucks *************
  static String addTruckUrl(){
    return "$BaseURL/drivers/addTruck";
  }
  static String updateTruckUrl(){
    return "$BaseURL/drivers/updateTruck";
  }
  static String updateTruckPhotoUrlInDatabase(){
    return "$BaseURL/drivers/updateTruckPhoto";
  }

  //************** Trailers *************

  static String addTrailerURl(){
    return "$BaseURL/drivers/addTrailer";
  }
  static String deleteTrailerURL(){
    return "$BaseURL/drivers/deleteTrailer";
  }

//************** Permits *************

  static String addPermitsURl(){
    return "$BaseURL/drivers/addPermitLicence";
  }
  static String deletePermitURL(){
    return "$BaseURL/drivers/deletePermitLicence";
  }
  
}