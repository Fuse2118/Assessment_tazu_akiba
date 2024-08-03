// ignore_for_file: unused_local_variable, avoid_print

import 'dart:async';

import 'package:assessment_tazu_akiba/server/api.dart';
import 'package:assessment_tazu_akiba/view/assessment/Main_Assessment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import '../../controller/get.dart';
import '../../server/shared_preferences.dart';

class ScreenServer extends StatefulWidget {
  const ScreenServer({super.key});

  @override
  State<ScreenServer> createState() => _ScreenServerState();
}

class _ScreenServerState extends State<ScreenServer> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        GetAssessmentBill(context);
      });
    });
    KeepScreenOn.turnOn();
    super.initState();
  }

  Future<void> GetAssessmentBill(BuildContext context) async {
    String tokenAssessment =
        await SharedPreferencesValue().getValueString("tokenAssessment");
    final dio = Dio();
    String url = Api_GetSurveyPaymentZero;
    Response response = await dio.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer $tokenAssessment'},
      ),
    );
    var status_code = response.data['status_code'][0]['code'];
    var result = response.data['results'];
    if (result != null) {
      setState(() {
        SurveyList = result;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainAssessment()),
          (Route<dynamic> route) => false,
        );
      });
    } else {
      setState(() {
        SurveyList = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Expanded(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Carousel(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                indicatorBarColor: Colors.transparent,
                autoScrollDuration: const Duration(seconds: 2),
                animationPageDuration: const Duration(milliseconds: 500),
                unActivatedIndicatorColor: Colors.transparent,
                activateIndicatorColor: Colors.transparent,
                animationPageCurve: Curves.linear,
                stopAtEnd: false,
                autoScroll: true,
                items: [
                  for (int i = 1; i <= 14; i++) ...{
                    Expanded(
                      child: Image.asset(
                        'images/$i.png',
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                  }
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
