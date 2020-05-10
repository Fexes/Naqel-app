import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naqelapp/models/DriverProfile.dart';
import 'package:naqelapp/utilts/URLs.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'DecodeToken.dart';
import 'UI/toast_utility.dart';

class UpdateTokenData{
  ProgressDialog pr;

  UpdateTokenData(BuildContext context){
    signin(context);
  }

  void signin(BuildContext context) async {




    pr = new ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);

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

/*
    Map<String, dynamic> updateMap = new Map<String, dynamic>.from(json.decode(contents));

    final client = HttpClient();
    final request = await client.postUrl(Uri.parse(URLs.loginUrl()));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");

    request.write('{"Authorization": "JWT '+updateMap["Token"]+'"}');

    final response = await request.close();
print("Status Code: $response.statusCode");
    response.transform(utf8.decoder).listen((contents) async {
      pr.hide();

      ToastUtils.showCustomToast(context, "Refreshed",true);
      DecodeToken(updateMap["Driver"]);

    });

 */
  }


}
