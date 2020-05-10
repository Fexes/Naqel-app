

class URLs{

  static String BaseURL = "https://naqel-server.azurewebsites.net/";

///************** Driver Auth *************/

  static String loginUrl(){
    return "$BaseURL/drivers/login";
  }

  static String getDriverUrl(){
    return "$BaseURL/drivers/getDriver";
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

  ///************** Trucks *************/

  static String getTruckUrl(){
    return "$BaseURL/drivers/getTruck";
  }
  static String addTruckUrl(){
    return "$BaseURL/drivers/addTruck";
  }
  static String updateTruckUrl(){
    return "$BaseURL/drivers/updateTruck";
  }
  static String updateTruckPhotoUrlInDatabase(){
    return "$BaseURL/drivers/updateTruckPhoto";
  }

  /// ************ Trailers *************/

  static String getTrailersUrl(){
    return "$BaseURL/drivers/getTrailers";
  }

  static String addTrailerURl(){
    return "$BaseURL/drivers/addTrailer";
  }
  static String deleteTrailerURL(){
    return "$BaseURL/drivers/deleteTrailer";
  }

///************** Permits *************/

  static String getPermitLicences(){
    return "$BaseURL/drivers/getPermitLicences";
  }
  static String addPermitsURl(){
    return "$BaseURL/drivers/addPermitLicence";
  }
  static String deletePermitURL(){
    return "$BaseURL/drivers/deletePermitLicence";
  }

  ///************** Documents *************/

  static String getDrivingLicenceURL(){
    return "$BaseURL/drivers/getDrivingLicence";
  }
  static String getEntryExitCardURL(){
    return "$BaseURL/drivers/getEntryExitCard";
  }
  static String getIdentityCardURL(){
    return "$BaseURL/drivers/getIdentityCard";
  }


  static String deleteDrivingLicenceURL(){
    return "$BaseURL/drivers/deleteDrivingLicence";
  }
  static String deleteEntryExitCardURL(){
    return "$BaseURL/drivers/deleteEntryExitCard";
  }
  static String deleteIdentityCardURL(){
    return "$BaseURL/drivers/deleteIdentityCard";
  }



  static String addDrivingLicenceURL(){
    return "$BaseURL/drivers/addDrivingLicence";
  }

  static String addIdentityCardURL(){
    return "$BaseURL/drivers/addIdentityCard";
  }
  ///************** Job Requests *************/

  static String getJobRequestPackagesURL(){
    return "$BaseURL/drivers/getJobRequestPackages";
  }
  static String deleteDriverRequestURL(){
    return "$BaseURL/drivers/deleteJobRequest";
  }

///************** Job Offers *************/

  static String getJobOfferPostsURL(){
    return "$BaseURL/drivers/getJobOfferPosts";
  }


}
