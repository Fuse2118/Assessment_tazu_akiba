// ignore_for_file: non_constant_identifier_names, avoid_print, unused_element, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../server/api.dart';
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
  try {
    Response response = await dio.post(
      url,
      data: {
        "username": textUsername.toString(),
        "password": textPassword.toString(),
      },
    );

    var result = response.data["results"];
    var status_code = response.data["status_code"][0]['code'];
    if (status_code == "200") {
      token = result['token'];
      Company_Id = result['id'];
      RememberPreferences(_isChecked_Login);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainScanPayment()),
        (Route<dynamic> route) => false,
      );
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
