import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naqelapp/session/Userprofile.dart';
import 'package:naqelapp/utilts/URLs.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'DecodeToken.dart';

class UpdateTokenData{
  ProgressDialog pr;

  UpdateTokenData(BuildContext context){
    signin(context);
  }

  void signin(BuildContext context) async {




    pr = new ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);

    pr.style(
        message: '     Refreshing...',
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


    final client = HttpClient();
    final request = await client.postUrl(Uri.parse(URLs.generalSettingUrl()));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");

    request.write('{"FirstName": "' + Userprofile.FirstName +
        '","Token": "'+Userprofile.getUserToken()+'", "LastName": "' + Userprofile.LastName +
        '", "Address": "' + Userprofile.Address + '", "DateOfBirth": "' + Userprofile.DateOfBirth +
        '", "PhoneNumber": "' + Userprofile.PhoneNumber + '", "Gender": "' + Userprofile.Gender +
        '", "Nationality": "' + Userprofile.Nationality + '"}');

    final response = await request.close();

    response.transform(utf8.decoder).listen((contents) async {

      pr.hide();
      //  parseJwt(contents);
      Map<String, dynamic> updateMap = new Map<String, dynamic>.from(json.decode(contents));

        DecodeToken(updateMap["Token"]);




    });
  }


}