import 'dart:convert';
import 'dart:io';

import 'package:naqelapp/utilts/toast_utility.dart';
import 'package:flutter/material.dart';
import 'package:naqelapp/styles/styles.dart';
import 'package:naqelapp/screens/auth/sign-in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../utilts/URLs.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool checkEmails = true;
  bool checkTerms = true;
  bool showText = true;

  FocusNode _focusNodeEmail, _focusNodePass, _focusNodeConPass,_focusNodeMobile,_focusNodeUsername,_focusNodeFirstName,_focusNodeLastName,_focusNodeNationality,_focusNodeCode;

  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNodeEmail = new FocusNode();
    _focusNodeEmail.addListener(_onOnFocusNodeEvent);

    _focusNodePass = new FocusNode();
    _focusNodePass.addListener(_onOnFocusNodeEvent);

    _focusNodeConPass = new FocusNode();
    _focusNodeConPass.addListener(_onOnFocusNodeEvent);

    _focusNodeMobile = new FocusNode();
    _focusNodeMobile.addListener(_onOnFocusNodeEvent);

    _focusNodeUsername = new FocusNode();
    _focusNodeUsername.addListener(_onOnFocusNodeEvent);

    _focusNodeFirstName = new FocusNode();
    _focusNodeFirstName.addListener(_onOnFocusNodeEvent);

    _focusNodeLastName = new FocusNode();
    _focusNodeLastName.addListener(_onOnFocusNodeEvent);

    _focusNodeNationality = new FocusNode();
    _focusNodeNationality.addListener(_onOnFocusNodeEvent);

    _focusNodeCode = new FocusNode();
    _focusNodeCode.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }

  void showPassword() {
    setState(() {
      showText =! showText;
    });
  }
  String date;
  String username;
  String email;
  String password;
  String password2;
  String mobilenumber;
  var errorText;

  bool loading = false;

  Firestore store;


  CollectionReference get users => store.collection('users');

  final databaseReference = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String dateSel = "Select Date of Birth";
  DateTime selectedDate = DateTime.now();
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


        dateSel=day+'/'+month+'/'+year;

      });
  }
  TextEditingController _codeController = TextEditingController();
  String entered_code;
  ProgressDialog pr;

  confirmationCode(BuildContext context,String code) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('A confirmation code has been sent to your E-mail address. Please enter that code to Signup'),
            content:TextFormField(
              controller: _codeController,
              cursorColor: Colors.black, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.text,

              validator: (String value) {
                if(value.isEmpty)
                  return 'Please Enter Confirmation code ';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),

                labelText: "Code",
              ),
              focusNode: _focusNodeCode,
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {

                  final FormState form = _formKey.currentState;
                  if (!form.validate()) {
                    return;
                  }

                  form.save();

                  print(_codeController.text);
                  if(_codeController.text==code){
                    Navigator.of(context).pop();
                    signup();
                  }else{
                    ToastUtils.showCustomToast(context, "Invalid code",false);

                  }


                },
              ),
            ],
          );
        });
  }
  void signup() async {

    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }

    form.save();

    pr = new ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);

    pr.style(
        message: 'Signing Up',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    pr.show();

    print(username);
    print(password);
    print(mobilenumber);
    print(email);
    print(dateSel);

    final client = HttpClient();
    final request = await client.postUrl(Uri.parse(URLs.signUpUrl()));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    request.write('{"Username": "'+username+'","Password": "'+password+'", "PhoneNumber": "'+mobilenumber+'", "FirstName": "*****", "LastName": "*****", "Nationality": "*****","Email": "'+email+'","Gender": "*****" ,"DateOfBirth": "'+dateSel+'","Address": "*****" }');

    final response = await request.close();

    response.transform(utf8.decoder).listen((contents) {
      print(contents);
      pr.hide();
 
      if(contents.contains("Driver created")){
        ToastUtils.showCustomToast(context, "SignUp Successful",true);
      }else{
        ToastUtils.showCustomToast(context, "SignUp Failed",false);
      }

    });
  }

  void registercheck() async {

    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }

    form.save();

    pr = new ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);

    pr.style(
        message: 'Signing Up',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    pr.show();

    print(username);
    print(password);
    print(mobilenumber);
    print(email);
    print(dateSel);

    final client = HttpClient();
    final request = await client.postUrl(Uri.parse(URLs.registercheckUrl()));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    request.write('{"Username": "'+username+'","Password": "'+password+'","Email": "'+email+'","RegisterAs": "Driver"}');

    final response = await request.close();

    response.transform(utf8.decoder).listen((contents) {
      print(contents);
      pr.hide();

      Map<String,dynamic> attributeMap = new Map<String,dynamic>();
      attributeMap=parseJwt(contents);

      print(attributeMap["Code"]);

      if(attributeMap["Code"]!=null){
        confirmationCode(context,attributeMap["Code"]);
      }




      if(contents.contains("Driver created")){
        ToastUtils.showCustomToast(context, "SignUp Successful",true);
      }else{
        ToastUtils.showCustomToast(context, "SignUp Failed",false);
      }

    });
  }

  Map<String, dynamic> parseJwt(String token) {

    final parts = token.split('.');
    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }



  @override
  Widget build(BuildContext context) {


    Widget userForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.account_circle),
          Container(
            width: screenWidth(context)*0.7,
            child: TextFormField(
              cursorColor: Colors.black, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.emailAddress,
              onSaved: (String value) {
                username = value;
              },
              validator: (String value) {
                if(value.isEmpty)
                  return 'Please Enter Username';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                labelText: "Username",
              ),
              focusNode: _focusNodeUsername,
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNodeUsername.hasFocus ? BorderSide(color: Colors.black, style: BorderStyle.solid, width: 2.0) :
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
                labelText: "Email Id",
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
                labelText: "Password",
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
                labelText: "Confirm Password",
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
                mobilenumber = value;
              },
              validator: (String value) {
                if(value.length > 12 || value.length < 10)
                  return 'Mobile Number should be 6 or more digits';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
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

    Widget date = Container(

      width: screenWidth(context)*0.7,
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
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


    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[

                Form(
                  key: _formKey,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    margin: EdgeInsets.only(top: 80.0),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/icons/logo.png", width: 200.0, height: 180.0, fit: BoxFit.contain,),
                        Text("Sign Up",style: TextStyle(fontSize: 32) ),
                        Container(
                          margin: EdgeInsets.only(top: 24.0,bottom: 30.0),
                          alignment: AlignmentDirectional.center,
                          width: screenWidth(context)*0.8,
                          child: Text("Sign Up for a new Naqel Account Now",
                           textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.topStart,
                          padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4.0, right: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Name",),
                              userForm,

                              Text("Email", ),
                              emailForm,
                              Text("Password",),
                              passwordForm,
                              confirmPassword,
                              Text("Detailes",),
                              mobile,
                              date,
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: primaryDark,
                              value: checkTerms,
                              onChanged: (bool value) {
                                setState(() {
                                  checkTerms = value;
                                });
                              },
                            ),
                            Container(

                              width: screenWidth(context)*0.74,
                              child: RichText(

                                text: new TextSpan(
                                  children: <TextSpan>[
                                    new TextSpan(text: 'I agree with the',style: TextStyle(color: Colors.black)),
                                    new TextSpan(text: ' Terms and Condition ',style: TextStyle(color: Colors.black)),
                                    new TextSpan(text: 'and the',style: TextStyle(color: Colors.black)),
                                    new TextSpan(text: ' Privacy Policy ', style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 12.0),
                          child: SizedBox(
                            width: 200,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),

                              ),
                              
                              color: primaryDark,
                              onPressed: () async {
                           //     await registerUser();
                                await registercheck();
                              },
                              child: Text( "SIGN UP",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                        RawMaterialButton(
                            onPressed: (){

                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Already have an account? ",),
                                Text("Sign in here",style: TextStyle(decoration: TextDecoration.underline,), )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}