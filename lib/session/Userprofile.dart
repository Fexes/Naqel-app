


class Userprofile {

  static int DriverID;
  static String Username;
  static String Password;
  static String PhoneNumber;
  static String FirstName;
  static String LastName;
  static String Nationality;
  static String Email;
  static String Gender;
  static String DateOfBirth;
  static String Address;
  static String ProfilePhotoURL;
  static int Active;
  static bool Complete;

  static void setComplete(bool data){
    Complete=data;
  }
  static void setProfileImage(String data){
    ProfilePhotoURL=data;
  }
  static void setDriverID(int data){
    DriverID=data;
  }
  static void setUsername(String data){
    Username=data;
  }
  static void setPassword(String data){
    Password=data;
  }
  static void setPhoneNumber(String data){
    PhoneNumber=data;
  }
  static void setFirstName(String data){
    FirstName=data;
  }
  static void setLastName(String data){
    LastName=data;
  }
  static void setNationality(String data){
    Nationality=data;
  }
  static void setEmail(String data){
    Email=data;
  }
  static void setGender(String data){
    Gender=data;
  }
  static void setDateOfBirth(String data){
    DateOfBirth=data;
  }
  static void setAddress(String data){
    Address=data;
  }
  static void setActive(int data){
    Active=data;
  }

  static String getProfileImage(){
    return ProfilePhotoURL;
  }

  static String getUsername(){
    return Username;
  }
  static int getDriverID(){
    return DriverID;
  }
  static String getPassword(){
    return Password;
  }
  static String getPhoneNumber(){
    return PhoneNumber;
  }
  static String getFirstName(){
    return FirstName;
  }
  static String getLastName(){
    return LastName;
  }
  static String getNationality(){
    return Nationality;
  }
  static String getEmail(){
    return Email;
  }
  static String getGender(){
    return Gender;
  }
  static String getDateOfBirth(){
    return DateOfBirth;
  }
  static String getAddress(){
    return Address;
  }
  static int getActive(){
    return Active;
  }

  static bool isComplete(){
    return Complete;
  }
}