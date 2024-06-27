// ignore_for_file: non_constant_identifier_names, avoid_print, unused_element

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../server/api.dart';
import '../view/assessment/screen_server.dart';
import '../view/scan_payment/main_scan_payment.dart';

String token = "";
bool _isChecked_Login = true;
var Company_Id;
Future<void> PostLoginSurvey(
  BuildContext context,
  textUsername,
  textPassword,
) async {
  String url = Api_Login;
  Dio dio = Dio();
  print(url);
  try {
    Response response = await dio.post(
      url,
      data: {
        "username": textUsername.toString(),
        "password": textPassword.toString(),
      },
    );

    var result = response.data["results"];
    print(result);
    var status_code = response.data["status_code"][0]['code'];
    print(status_code);
    if (status_code == "200") {
      token = result['token'];
      Company_Id = result['id'];
      RememberPreferences(_isChecked_Login);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainScanPayment()),
          (Route<dynamic> route) => false);
    } else {}
  } catch (e) {
    // AlertUserPassworNullFall(context);
    print(e);
    print('ไม่เข้า');
  }
}

void RememberPreferences(value) {
  print("_isChecked_Login $_isChecked_Login");
  _isChecked_Login = value;
  SharedPreferences.getInstance().then(
    (prefs) {
      prefs.setBool("remember_me", value);
      prefs.setString('token', token);
      prefs.setString('Company_Id', Company_Id);
    },
  );
  void setState(value) {
    _isChecked_Login = value;
    token;
    Company_Id;
  }
}

String tokenAssessment = "";
bool _isChecked_Assessment_Login = true;
Future<void> PostLoginAssessment(
  BuildContext context,
  textUsername,
  textPassword,
) async {
  String url = Api_Login;
  Dio dio = Dio();
  print(url);
  try {
    Response response = await dio.post(
      url,
      data: {
        "username": textUsername.toString(),
        "password": textPassword.toString(),
      },
    );

    var result = response.data["results"];
    print(result);
    var status_code = response.data["status_code"][0]['code'];
    print(status_code);
    if (status_code == "200") {
      tokenAssessment = result['token'];
      RememberPreferencesAssessment(_isChecked_Assessment_Login);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ScreenServer()),
          (Route<dynamic> route) => false);
    } else {}
  } catch (e) {
    // AlertUserPassworNullFall(context);
    print(e);
    print('ไม่เข้า');
  }
}

void RememberPreferencesAssessment(value) {
  print("_isChecked_Assessment_Login $_isChecked_Assessment_Login");
  _isChecked_Assessment_Login = value;
  SharedPreferences.getInstance().then(
    (prefs) {
      prefs.setBool("remember_me", value);
      prefs.setString('tokenAssessment', tokenAssessment);
    },
  );
  void setState(value) {
    _isChecked_Assessment_Login = value;
    tokenAssessment;
  }
}
