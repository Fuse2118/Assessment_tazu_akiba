// ignore_for_file: unused_local_variable, avoid_print

import 'dart:async';

import 'package:assessment_tazu_akiba/server/api.dart';
import 'package:assessment_tazu_akiba/view/assessment/Main_Assessment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
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
        if (timer.tick >= 3) {
          timer.cancel();
        } else {
          StartTimer();
        }
      });
    });

    super.initState();
  }

  void StartTimer() {
    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        print('  เข้า55555');
        Future.delayed(const Duration(seconds: 8), () {
          initState();
        });
      });
    });
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
    print('result: $result');
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
      body: Column(
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
                Expanded(
                  child: Image.asset(
                    'images/silde1.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'images/silde2.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'images/silde3.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
