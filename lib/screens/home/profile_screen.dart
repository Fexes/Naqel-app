import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:naqelapp/styles/app_theme.dart';
import 'package:naqelapp/styles/styles.dart';
import 'package:naqelapp/utilts/toast_utility.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../../utilts/URLs.dart';
import '../../session/Userprofile.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class MyProfilePage extends StatefulWidget  {


  const MyProfilePage({Key key}) : super(key: key);



  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>  {

  bool checkEmails = true;
  bool checkTerms = true;
  bool showText = true;

  FocusNode _focusNodeEmail, _focusNodePass, _focusNodeConPass,_focusNodeMobile,_focusNodeFirstName,_focusNodeLastName,_focusNodeNationality,_focusNodeAddress;
  @override
  void initState() {
    super.initState();
    loadData();


    _focusNodeEmail = new FocusNode();
    _focusNodeEmail.addListener(_onOnFocusNodeEvent);

    _focusNodePass = new FocusNode();
    _focusNodePass.addListener(_onOnFocusNodeEvent);

    _focusNodeConPass = new FocusNode();
    _focusNodeConPass.addListener(_onOnFocusNodeEvent);

    _focusNodeMobile = new FocusNode();
    _focusNodeMobile.addListener(_onOnFocusNodeEvent);



    _focusNodeFirstName = new FocusNode();
    _focusNodeFirstName.addListener(_onOnFocusNodeEvent);

    _focusNodeLastName = new FocusNode();
    _focusNodeLastName.addListener(_onOnFocusNodeEvent);

    _focusNodeNationality = new FocusNode();
    _focusNodeNationality.addListener(_onOnFocusNodeEvent);

    _focusNodeAddress = new FocusNode();
    _focusNodeAddress.addListener(_onOnFocusNodeEvent);
  }
  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
  }
  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }
  String first_name,last_name,date_of_birth,gender,nationality,mobilenumber,address;
  int driver_id;
  String email;
  String password;
  String password2;
   var errorText;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image.path);
    setState(() {
      _image = image;
      if(_image!=null) {
        pr.show();
        uploadPic();
      }
    });
  }
  void showPassword() {
    setState(() {
      showText =! showText;
    });
  }

  DateTime selectedDate = DateTime.now();
  String dateSel = "Select Date of Birth";
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {


        selectedDate = new DateTime(picked.year, picked.month, picked.day);
        String day = selectedDate.day.toString();
        String month ;
        String year = selectedDate.year.toString();

        switch (selectedDate.month) {
          case 1:
            month = "Jan";
            break;
          case 2:
            month = "Feb";
            break;
          case 3:
            month = "Mar";
            break;
          case 4:
            month = "Apr";
            break;
          case 5:
            month = "May";
            break;
          case 6:
            month = "Jun";
            break;
          case 7:
            month = "Jul";
            break;
          case 8:
            month = "Aug";
            break;
          case 9:
            month = "Sep";
            break;
          case 10:
            month = "Oct";
            break;
          case 11:
            month = "Nov";
            break;
          case 12:
            month = "Dec";
            break;
        }


        dateSel=day+' - '+month+' - '+year;
        date_of_birth=dateSel;
      });
  }
  int selectedRadio;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      switch (val){
        case 1:
          gender="Male";
          break;
        case 2:
          gender="Female";
          break;
        case 3:
          gender="Other";
          break;
      }
    });
  }


  int DriverID ;
  String Username ,ProfilePhotoURL;
  String Password ;
  String PhoneNumber ;
  String FirstName ;
  String LastName ;
  String Nationality;
  String Email ;
  String Gender  ;
  String DateOfBirth ;
  String Address ;
  int Active;
  Future<Timer> loadData()  {


     DriverID = Userprofile.getDriverID();
     Username = Userprofile.getUsername();
     ProfilePhotoURL =  Userprofile.getProfileImage();
     Password =  Userprofile.getPassword();
     PhoneNumber =   Userprofile.getPhoneNumber();
     FirstName = Userprofile.getFirstName();
     LastName =  Userprofile.getLastName();
     Nationality =  Userprofile.getNationality();
     Email =   Userprofile.getEmail();
     Gender =  Userprofile.getGender();
     DateOfBirth =  Userprofile.getDateOfBirth();
     Address =   Userprofile.getAddress();
     Active =  Userprofile.getActive();


     dateSel=DateOfBirth;
     driver_id=DriverID;
      first_name=FirstName;
      last_name=LastName;
      date_of_birth=DateOfBirth;
      gender=Gender;
      nationality=Nationality;
      mobilenumber=PhoneNumber;
      address=Address;
      email=Email;

     setState(() {
       switch(Gender){
         case "Male":
           selectedRadio=1;
           setSelectedRadio(1);
           break;
         case "Female":
           selectedRadio=2;
           setSelectedRadio(2);
           break;
         case "Other":
           selectedRadio=3;
           setSelectedRadio(3);
           break;
       }
     });

  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    pr.style(
        message: '     Updating Profile...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    Widget firstNameForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      width: screenWidth(context)*0.35,
      child: Row(
        children: <Widget>[
          Icon(Icons.account_circle,color: Userprofile.getFirstName()==""? Colors.redAccent : Colors.black,),
          Container(
            width: (screenWidth(context)*0.3)-4,
            child: TextFormField(

              cursorColor: Colors.black, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.text,
              onSaved: (String value) {
                if(!value.isEmpty){
                  first_name = value;
                }

              },
              validator: (String value) {
                if(value.isEmpty)
                  return 'Please Enter First Name';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                 hintText: Userprofile.getFirstName(),
                labelText: "First Name",
              ),
              focusNode: _focusNodeLastName,
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNodeLastName.hasFocus ? BorderSide(color: Colors.black, style: BorderStyle.solid, width: 2.0) :
          BorderSide(color: Colors.black.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    Widget lastNameForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      width: screenWidth(context)*0.35,
      child: Row(
        children: <Widget>[
          Icon(Icons.account_circle,color: Userprofile.getLastName()==""? Colors.redAccent : Colors.black,),
          Container(
            width: (screenWidth(context)*0.3)-4,
            child: TextFormField(
              cursorColor: Colors.black, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,

              keyboardType: TextInputType.text,
              onSaved: (String value) {
                if(!value.isEmpty)
                last_name = value;
              },
              validator: (String value) {
                if(value.isEmpty)
                  return 'Please Enter Last Name';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: Userprofile.getLastName(),
                labelText: "Last Name",
              ),
              focusNode: _focusNodeFirstName,
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNodeFirstName.hasFocus ? BorderSide(color: Colors.black, style: BorderStyle.solid, width: 2.0) :
          BorderSide(color: Colors.black.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    Widget emailForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.mail),
          Container(
            width: screenWidth(context)*0.7,
            child: TextFormField(
              cursorColor: Colors.black, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.emailAddress,
              onSaved: (String value) {
                if(!value.isEmpty)
                email = value;
              },
              validator: (String value) {
                if(value.isEmpty)
                  return 'Please Enter Email Id';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                 hintText: Userprofile.getEmail(),
                 labelText: "Email Address",
              ),
              focusNode: _focusNodeEmail,
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNodeEmail.hasFocus ? BorderSide(color: Colors.black, style: BorderStyle.solid, width: 2.0) :
          BorderSide(color: Colors.black.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    Widget passwordForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.lock),
          Container(
            width: screenWidth(context)*0.72,
            child: TextFormField(
              cursorColor: Colors.black, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              onSaved: (value) => password = value,
              validator: (String value) {
                if(value.length < 6)
                  return 'Password should be 6 or more digits';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                labelText: "New Password",
              ),
              focusNode: _focusNodePass,
              obscureText: showText,
            ),
          ),
          InkWell(
              onTap: showPassword,
              child: showText ?  Icon(Icons.visibility_off,color: Colors.grey[500],) :
              Icon(Icons.visibility,color: primaryDark,)
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNodePass.hasFocus ? BorderSide(color: Colors.black, style: BorderStyle.solid, width: 2.0) :
          BorderSide(color: Colors.black.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    Widget confirmPassword = Container(
      margin: EdgeInsets.only(bottom: 18.0),

      child: Row(
        children: <Widget>[
          Icon(Icons.lock),
          Container(
            width: screenWidth(context)*0.72,
            child: TextFormField(
              cursorColor: Colors.black, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              onSaved: (value) => password2 = value,
              validator: (String value) {
                if(value.length < 6)
                  return 'Password should be 6 or more digits';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                labelText: confermpassword,
              ),
              focusNode: _focusNodeConPass,
              obscureText: showText,
            ),
          ),
          InkWell(
              onTap: showPassword,
              child: showText ?  Icon(Icons.visibility_off,color: Colors.grey[500],) :
              Icon(Icons.visibility,color: primaryDark,)
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNodeConPass.hasFocus ? BorderSide(color: Colors.black, style: BorderStyle.solid, width: 2.0) :
          BorderSide(color: Colors.black.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    Widget mobile  = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.phone_android),
          Container(
            width: screenWidth(context)*0.7,
            child: TextFormField(
              cursorColor: Colors.black, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.number,
              onSaved: (String value) {
                if(!value.isEmpty)
                mobilenumber = value;
              },
              validator: (String value) {
                if(value.length != 11)
                  return 'Mobile Number should be 11 digits';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),

                hintText: Userprofile.getPhoneNumber(),
                labelText: "Mobile Number",

              ),
              focusNode: _focusNodeMobile,
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNodeMobile.hasFocus ? BorderSide(color: Colors.black, style: BorderStyle.solid, width: 2.0) :
          BorderSide(color: Colors.black.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    Widget addressForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.home,color: Userprofile.getAddress()==""? Colors.redAccent : Colors.black,),
          Container(
            width: screenWidth(context)*0.7,
            child: TextFormField(
              cursorColor: Colors.black, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.text,
              onSaved: (String value) {
                if(!value.isEmpty)
                address = value;
              },
              validator: (String value) {
                if(value.isEmpty)
                  return 'Please Enter Address';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),

                hintText: Userprofile.getAddress(),
                labelText: "Address",
              ),
              focusNode: _focusNodeAddress,
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNodeAddress.hasFocus ? BorderSide(color: Colors.black, style: BorderStyle.solid, width: 2.0) :
          BorderSide(color: Colors.black.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    Widget nationalityForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.local_airport,color: Userprofile.getNationality()==""? Colors.redAccent : Colors.black,),
          Container(
            width: screenWidth(context)*0.7,
            child: TextFormField(
              cursorColor: Colors.black, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.text,
              onSaved: (String value) {
                if(!value.isEmpty)
                nationality = value;
              },
              validator: (String value) {
                if(value.isEmpty)
                  return 'Please Enter Nationality';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                 hintText: Userprofile.getNationality(),
                labelText: "Nationality",
              ),
              focusNode: _focusNodeNationality,
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNodeNationality.hasFocus ? BorderSide(color: Colors.black, style: BorderStyle.solid, width: 2.0) :
          BorderSide(color: Colors.black.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    Widget genderForm = Container(

      margin: EdgeInsets.only(bottom: 18.0),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: selectedRadio,
            activeColor: Colors.redAccent,
            onChanged: (val) {
              print("Radio $val");
              setSelectedRadio(val);
            },
          ),

          InkWell(
            child: Text("Male"),
            onTap: () {setSelectedRadio(1);},
          ),
          Radio(
            value: 2,
            groupValue: selectedRadio,
            activeColor: Colors.redAccent,
            onChanged: (val) {
              print("Radio $val");
              setSelectedRadio(val);
            },
          ),
          InkWell(
            child: Text("Female"),
            onTap: () {setSelectedRadio(2);},
          ),

          Radio(
            value: 3,
            groupValue: selectedRadio,
            activeColor: Colors.redAccent,
            onChanged: (val) {
              print("Radio $val");
              setSelectedRadio(val);
            },
          ),
          InkWell(
            child: Text("Other"),
            onTap: () {setSelectedRadio(3);},
          ),
        ],
      )
    );

    Widget date = Container(
       margin: EdgeInsets.only(bottom: 18.0),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.calendar_today),
          Container(
            child: FlatButton(

              child: Text(dateSel,textAlign: TextAlign.start,),
              onPressed: () => _selectDate(context),
            ),
          ),
        ],
      ),

    );
    ScrollController _scrollController = new ScrollController();

    return Align(

      child: SafeArea(

        child: Scaffold(
          appBar: AppBar(
               backgroundColor: Colors.white,

            title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Text('Profile',style: TextStyle(color: Colors.black),),
                ]
            ),
          ),
          backgroundColor: Color(0xffF7F7F7),
          body: GestureDetector(

              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[

                    Form(
                          key: _formKey,
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        margin: EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 20),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Stack(
                                      alignment:new Alignment(1, 1),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                          child: Container(
                                            height: 280,
                                            width: 280,
                                            decoration: BoxDecoration(

                                              shape: BoxShape.circle,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: AppTheme.grey.withOpacity(0.6),
                                                    offset: const Offset(2.0, 4.0),
                                                    blurRadius: 8),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                              const BorderRadius.all(Radius.circular(360.0)),
                                              child: _image == null
                                                  ?   Userprofile.getProfileImage()==null ? Icon(Icons.account_circle,color: Colors.grey,size: 130,) :  Image.network(Userprofile.getProfileImage(),fit: BoxFit.cover)

                                                : Image.file(_image,fit: BoxFit.cover),

                                            ),
                                          ),
                                        ),

                                        new Positioned(
                                          right:10.0,
                                          bottom: 10.0,
                                          child:  FloatingActionButton(
                                            onPressed: getImage,
                                            backgroundColor: Colors.red[800],
                                            tooltip: 'Pick Image',
                                            child: Icon(Icons.add_a_photo),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 18, left: 4),
                                  child: Text(
                                    Userprofile.getUsername(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.grey,
                                      fontSize: 28,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20),

                                Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.contact_mail,size: 19,),
                                        Icon(Icons.account_circle,size: 19,),
                                        Icon(Icons.account_circle,size: 19,),
                                        Icon(Icons.phone_android,size: 19,),
                                        Icon(Icons.home,size: 19,),
                                        Icon(Icons.airplanemode_active,size: 19,),
                                        Icon(Icons.calendar_today,size: 19,),
                                        Icon(Icons.wc,size: 19,),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text("Email Address: ",
                                            style: TextStyle(
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text("First Name: ",
                                            style: TextStyle(
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text("Last Name: ",
                                            style: TextStyle(
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text("Mobile Number: ",
                                            style: TextStyle(
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text("Home Address: ",
                                            style: TextStyle(
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text("Nationality: ",
                                            style: TextStyle(
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text("Date Of Birth: ",
                                            style: TextStyle(
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text("Gender: ",
                                            style: TextStyle(
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text(
                                            Userprofile.getEmail(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text(
                                            Userprofile.getFirstName(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text(
                                            Userprofile.getLastName(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text(
                                            Userprofile.getPhoneNumber(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text(
                                            Userprofile.getAddress(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text(
                                            Userprofile.getNationality(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text(
                                            Userprofile.getDateOfBirth(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0),
                                          child: Text(
                                            Userprofile.getGender(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),





                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(30,0,30,0),
                                  child: Divider(
                                    height: 1,
                                    color: AppTheme.grey.withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                Text(
                                  "Update Info",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.grey,
                                    fontSize: 26,
                                  ),),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Listener(
                                        child: new InkWell(
                                          child: updteDetails==true? Column(
                                             children: <Widget>[
                                               Icon(Icons.contact_mail,color: Colors.red,size: 30,),
                                                const SizedBox(height: 10,),
                                                Text("Details",style: TextStyle(color: Colors.red),),
                                               Text("                                                          ",style: TextStyle(fontSize: 8, color: Colors.red,decoration: TextDecoration.underline,decorationThickness: 5),),

                                             ],
                                            ):Column(
                                                              children: <Widget>[
                                                              Icon(Icons.contact_mail,color: Colors.black,),
                                                          const SizedBox(height: 10,),
                                                          Text("Details",style: TextStyle(color: Colors.black),),

                                                          ],
                                                        ),
                                            onTap: () {

                                              _scrollController.animateTo(
                                                500,
                                                curve: Curves.easeOut,
                                                duration: const Duration(milliseconds: 500),
                                              );
                                              setState(() {
                                                updteDetails=true;
                                                updteEmail=false;
                                                updtePAssword=false;


                                              });
                                            }
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),

                                      new Listener(
                                        child: new InkWell(
                                            child: updteEmail==true? Column(
                                              children: <Widget>[
                                                Icon(Icons.mail,color: Colors.red,size: 30,),
                                                const SizedBox(height: 10,),
                                                Text("Email",style: TextStyle(color: Colors.red),),
                                                Text("                                                          ",style: TextStyle(fontSize: 8, color: Colors.red,decoration: TextDecoration.underline,decorationThickness: 5),),
                                              ],
                                            ):Column(
                                              children: <Widget>[
                                                Icon(Icons.mail,color: Colors.black,),
                                                const SizedBox(height: 10,),
                                                Text("Email",style: TextStyle(color: Colors.black),),

                                              ],
                                            )
                                            ,
                                            onTap: () {

                                              _scrollController.animateTo(
                                                500,
                                                curve: Curves.easeOut,
                                                duration: const Duration(milliseconds: 500),
                                              );
                                              setState(() {
                                                updteEmail=true;
                                                updteDetails=false;
                                                updtePAssword=false;


                                              });
                                            }
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      new Listener(
                                        child: new InkWell(
                                            child: updtePAssword==true? Column(
                                              children: <Widget>[
                                                Icon(Icons.lock,color: Colors.red,size: 30,),
                                                const SizedBox(height: 10,),
                                                Text("Password",style: TextStyle(color: Colors.red),),
                                                Text("                                                          ",style: TextStyle(fontSize: 8, color: Colors.red,decoration: TextDecoration.underline,decorationThickness: 5),),

                                              ],
                                            ):Column(
                                              children: <Widget>[
                                                Icon(Icons.lock,color: Colors.black,),
                                                const SizedBox(height: 10,),
                                                Text("Password",style: TextStyle(color: Colors.black),),

                                              ],
                                            ),
                                            onTap: () {

                                              _scrollController.animateTo(
                                                500,
                                                curve: Curves.easeOut,
                                                duration: const Duration(milliseconds: 500),
                                              );
                                              setState(() {
                                                updtePAssword=true;
                                                updteDetails=false;
                                                updteEmail=false;


                                              });
                                            }
                                        ),
                                      ),
                                    ],
                                  ),
                                ),



                              ],
                            ),
                            Visibility(
                              visible: updteDetails,
                              child: Container(

                                alignment: AlignmentDirectional.topStart,
                                padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4.0, right: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Text("General Details",),
                                    SizedBox(height: 10,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        firstNameForm,
                                        SizedBox(width: (screenWidth(context)*0.1)+16),
                                        lastNameForm
                                      ],
                                    ),

                                    nationalityForm,
                                    mobile,
                                    addressForm,
                                    date,
                                    genderForm,


                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
                                        child: SizedBox(
                                          width: 200,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(18.0),

                                            ),

                                            color: primaryDark,
                                            onPressed: ()  {
                                              final FormState form = _formKey.currentState;
                                              form.save();

                                              updateSettings(context);

                                            },
                                            child: Text( "UPDATE",style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),



                            Visibility(
                              visible: updteEmail,
                              child: Container(

                                alignment: AlignmentDirectional.topStart,
                                padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4.0, right: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Text("Email", ),
                                    SizedBox(height: 10,),
                                    emailForm,

                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
                                        child: SizedBox(
                                          width: 200,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(18.0),

                                            ),

                                            color: primaryDark,
                                            onPressed: ()  {
                                              final FormState form = _formKey.currentState;
                                              form.save();

                                              updateEmailSettings(context);

                                            },
                                            child: Text( "UPDATE",style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            Visibility(
                              visible: updtePAssword,
                              child: Container(

                                alignment: AlignmentDirectional.topStart,
                                padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4.0, right: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Text("Passwords",),
                                    SizedBox(height: 10,),
                                    passwordForm,
                                    confirmPassword,

                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
                                        child: SizedBox(
                                          width: 200,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(18.0),

                                            ),

                                            color: primaryDark,
                                            onPressed: ()  {
                                              final FormState form = _formKey.currentState;
                                              form.save();

                                              updatePassword(context);

                                            },
                                            child: Text( "UPDATE",style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),



                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),



        ),
      ),
    );
  }
  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }

    return double.parse(s, (e) => null) != null ||
        int.parse(s, onError: (e) => null) != null;
  }

  bool updteDetails=false;
  bool updteEmail=false;
  bool updtePAssword=false;

  ProgressDialog pr;
  Future updateSettings(BuildContext context) async {


    if(isNumeric(mobilenumber)) {
      pr.show();

      final client = HttpClient();
      final request = await client.postUrl(Uri.parse(URLs.generalSettingUrl()));
      request.headers.set(
          HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");

      request.write('{"FirstName": "' + first_name +
          '","DriverID": $driver_id, "LastName": "' + last_name +
          '", "Address": "' + address + '", "DateOfBirth": "' + date_of_birth +
          '", "PhoneNumber": "' + mobilenumber + '", "Gender": "' + gender +
          '", "Nationality": "' + nationality + '"}');

      final response = await request.close();

      response.transform(utf8.decoder).listen((contents) async {
        print(contents);
        ToastUtils.showCustomToast(
            context, "Detailes Updated Successfully", true);

        Userprofile.setUsername(Username);
        Userprofile.setPassword(Password);
        Userprofile.setPhoneNumber(mobilenumber);
        Userprofile.setFirstName(first_name);
        Userprofile.setLastName(last_name);
        Userprofile.setNationality(nationality);
        Userprofile.setEmail(email);
        Userprofile.setGender(gender);
        Userprofile.setDateOfBirth(date_of_birth);
        Userprofile.setAddress(address);

        if(first_name==""||last_name==""||nationality==""||address==""||gender=="") {
          Userprofile.setComplete(true);
        }else{
          Userprofile.setComplete(false);
        }


        pr.dismiss();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('DriverID', DriverID);
        prefs.setString('Username', Username);
        prefs.setString('Password', Password);
        prefs.setString('PhoneNumber', PhoneNumber);
        prefs.setString('FirstName', FirstName);
        prefs.setString('LastName', LastName);
        prefs.setString('Nationality', Nationality);
        prefs.setString('Email', Email);
        prefs.setString('Gender', Gender);
        prefs.setString('DateOfBirth', DateOfBirth);
        prefs.setString('Address', Address);
        prefs.setInt('Active', Active);



        print(first_name);
        print(last_name);
        print(date_of_birth);
        print(gender);
        print(nationality);
        print(mobilenumber);
        print(address);
        print(email);
        //      print(password);
        //     print(password2);
        _image = null;
        setState(() {
          // Re-renders
        });
      });
    }else{
      ToastUtils.showCustomToast(context, "Invalid Phone Number",false);

    }
  }

  Future updateEmailSettings(BuildContext context) async {

    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    if(EmailValidator.validate(email)) {
      pr.show();

      final client = HttpClient();
      final request = await client.postUrl(Uri.parse(URLs.emailSettingUrl()));
      request.headers.set(
          HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");

      request.write('{"Username": "' + Userprofile.getUsername() +
          '","DriverID": $driver_id, "Email": "' + email + '"}');

      final response = await request.close();

      response.transform(utf8.decoder).listen((contents) async {
        print(contents);
        ToastUtils.showCustomToast(context, "Email Updated Successfully", true);


        Userprofile.setEmail(email);
        pr.dismiss();

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('Email', Email);


        print(first_name);
        print(last_name);
        print(date_of_birth);
        print(gender);
        print(nationality);
        print(mobilenumber);
        print(address);
        print(email);
        //      print(password);
        //     print(password2);
        _image = null;
        setState(() {
          // Re-renders
        });
      });
    }else{
      ToastUtils.showCustomToast(context, "Invalid Email Address", false);

    }
  }

  Future updatePassword(BuildContext context) async {

    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    if(password==password2&&(password!=""||password2!="")) {
      confermpassword="Confirm Password";
      pr.show();
      final client = HttpClient();
      final request = await client.postUrl(
          Uri.parse(URLs.passwordSettingUrl()));
      request.headers.set(
          HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");

      request.write('{"DriverID": $driver_id, "Password": "' + password + '"}');
      final response = await request.close();

      response.transform(utf8.decoder).listen((contents) async {
        print(contents);
        pr.dismiss();
        ToastUtils.showCustomToast(context, "Password Updated Successfully",true);

        _image = null;
        setState(() {
          // Re-renders
        });
      });
    }else if (password==""||password2==""){
      pr.dismiss();
      ToastUtils.showCustomToast(context, "Please Enter Password",false);
      setState(() {
        // Re-renders
      });
    }
    else{
      pr.dismiss();
      ToastUtils.showCustomToast(context, "Password Does Not Match",false);
      setState(() {
        // Re-renders
      });
    }
  }


 String confermpassword="Confirm Password";
  Future updatePicUrl(String s) async {

    print("Updating URL");

    final client = HttpClient();
    final request = await client.postUrl(Uri.parse(URLs.updatePhotoUrlInDatabase()));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");

    request.write('{"DriverID": $driver_id,"URL": "'+s+'", "FileName": "'+Userprofile.getEmail()+'"}');

    final response = await request.close();

    response.transform(utf8.decoder).listen((contents) async {
      print(contents);

      pr.dismiss();
   //   Userprofile.setDriverID(DriverID);
      Userprofile.setProfileImage(s);

      SharedPreferences prefs = await SharedPreferences.getInstance();


      //Userprofile.setActive(Active);

      Userprofile.setUsername(Username);
      Userprofile.setPassword(Password);
      Userprofile.setPhoneNumber(mobilenumber);
      Userprofile.setFirstName(first_name);
      Userprofile.setLastName(last_name);
      Userprofile.setNationality(nationality);
      Userprofile.setEmail(email);
      Userprofile.setGender(gender);
      Userprofile.setDateOfBirth(date_of_birth);
      Userprofile.setAddress(address);
      if(first_name==""||last_name==""||nationality==""||address==""||gender=="") {
        Userprofile.setComplete(true);
      }else{
        Userprofile.setComplete(false);
      }
      pr.dismiss();

      prefs.remove("DriverID");
      prefs.remove("ProfilePhotoURL");
      prefs.remove("Username");
      prefs.remove("Password");
      prefs.remove("PhoneNumber");
      prefs.remove("FirstName");
      prefs.remove("LastName");
      prefs.remove("Nationality");
      prefs.remove("Email");
      prefs.remove("Gender");
      prefs.remove("DateOfBirth");
      prefs.remove("Address");
      prefs.remove("Active");



      prefs.setInt('DriverID',DriverID);
      prefs.setString('ProfilePhotoURL', s);
      prefs.setString('Username', Username);
      prefs.setString('Password', Password);
      prefs.setString('PhoneNumber', PhoneNumber);
      prefs.setString('FirstName', FirstName);
      prefs.setString('LastName',LastName);
      prefs.setString('Nationality', Nationality);
      prefs.setString('Email', Email);
      prefs.setString('Gender', Gender);
      prefs.setString('DateOfBirth', DateOfBirth);
      prefs.setString('Address',Address);
      prefs.setInt('Active', Active);


      print(first_name);
      print(last_name);
      print(date_of_birth);
      print(gender);
      print(nationality);
      print(mobilenumber);
      print(address);
      print(email);
    //  print(password);
    //  print(password2);
      _image=null;
      setState(() {
        // Re-renders
      });


    });


  }

  Future uploadPic() async{



    print("Uploading picture");
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("ProfilePhoto").child("$driver_id");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL();

    String s =await (await uploadTask.onComplete).ref.getDownloadURL();
    print (s);
    updatePicUrl(s);


  }
}
