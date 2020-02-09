

class URLs{


  static String updateTruckUrl(){
    return "https://naqelserver.azurewebsites.net/users/dashboard/updateTruck";
  }

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
    return "https://naqelserver.azurewebsites.net/users/updateTruckPhoto";
  }

  static String updateTruckPhotoUrlInDatabase(){
    return "https://naqelserver.azurewebsites.net/users/dashboard/updateTruckPhoto";
  }
}