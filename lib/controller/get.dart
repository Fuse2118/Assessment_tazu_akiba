// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../server/api.dart';
import '../server/shared_preferences.dart';
import '../view/assessment/Main_Assessment.dart';
import '../view/scan_payment/main_scan_payment.dart';

var SurveyList;
Future<void> GetSurveyPayment(BuildContext context) async {
  String gettoken = await SharedPreferencesValue().getValueString("token");
  final dio = Dio();
  String url = Api_GetSurveyPaymentZero;
  Response response = await dio.get(
    url,
    options: Options(
      headers: {'Authorization': 'Bearer $gettoken'},
    ),
  );
  var status_code = response.data['status_code'][0]['code'];
  var result = response.data['results'];
  print('result: $result');
  if (status_code == '200') {
    SurveyList = result;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainScanPayment()),
      (Route<dynamic> route) => false,
    );
  } else {
    SurveyList = "";
  }
  print(result);
}

Future<void> GetSurveyPaymentReload(BuildContext context) async {
  String gettoken = await SharedPreferencesValue().getValueString("token");
  final dio = Dio();
  String url = Api_GetSurveyPaymentZero;
  Response response = await dio.get(
    url,
    options: Options(
      headers: {'Authorization': 'Bearer $gettoken'},
    ),
  );
  var status_code = response.data['status_code'][0]['code'];
  var result = response.data['results'];
  print('result: $status_code');
  if (status_code == '200') {
    SurveyList = result;
  } else {
    SurveyList = "";
  }
  print(result);
}

Future<void> GetAssessmentBill(BuildContext context) async {
  String gettoken = await SharedPreferencesValue().getValueString("token");
  final dio = Dio();
  String url = Api_GetSurveyPaymentZero;
  Response response = await dio.get(
    url,
    options: Options(
      headers: {'Authorization': 'Bearer $gettoken'},
    ),
  );
  var status_code = response.data['status_code'][0]['code'];
  var result = response.data['results'];
  print('result: $result');
  if (result != null) {
    SurveyList = result;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainAssessment()),
      (Route<dynamic> route) => false,
    );
  } else {
    SurveyList = "";
  }
  print(result);
}
