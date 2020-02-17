

class URLs{


//************** User Auth *************

  static String loginUrl(){
    return "https://naqelserver.azurewebsites.net/users/login";
  }
  static String registercheckUrl(){
    return "https://naqelserver.azurewebsites.net/users/register";
  }
  static String signUpUrl(){
    return "https://naqelserver.azurewebsites.net/users/accountSetup";
  }
  static String generalSettingUrl(){
    return "https://naqelserver.azurewebsites.net/users/dashboard/generalSettings";
  }
  static String emailSettingUrl(){
    return "https://naqelserver.azurewebsites.net/users/dashboard/usernameAndEmailSettings";
  }

  static String passwordSettingUrl(){
    return "https://naqelserver.azurewebsites.net/users/dashboard/passwordSettings";
  }

  static String updatePhotoUrlInDatabase(){
    return "https://naqelserver.azurewebsites.net/users/uploadDriverProfilePhoto";
  }

  //************** Trucks *************



  static String updateTruckUrl(){
    return "https://naqelserver.azurewebsites.net/users/dashboard/updateTruck";
  }

  static String updateTruckPhotoUrlInDatabase(){
    return "https://naqelserver.azurewebsites.net/users/dashboard/updateTruckPhoto";
  }

  //************** Trailers *************

  static String addTrailerURl(){
    return "https://naqelserver.azurewebsites.net/users/dashboard/addTrailer";
  }

  static String deleteTrailerURL(){
    return "https://naqelserver.azurewebsites.net/users/dashboard/deleteTrailer";
  }


}