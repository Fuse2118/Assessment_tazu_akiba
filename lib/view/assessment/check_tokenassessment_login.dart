// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, avoid_print

import 'package:assessment_tazu_akiba/controller/get.dart';
import 'package:assessment_tazu_akiba/unity/colors_style.dart';
import 'package:assessment_tazu_akiba/view/assessment/login_assessment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../server/api.dart';
import '../../server/shared_preferences.dart';
import 'screen_server.dart';

class CheckTokenAssessment extends StatefulWidget {
  const CheckTokenAssessment({super.key});

  @override
  State<CheckTokenAssessment> createState() => _CheckTokenAssessmentState();
}

class _CheckTokenAssessmentState extends State<CheckTokenAssessment> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    Future.delayed(Duration(seconds: 2), () async {
      String tokenAssessment =
          await SharedPreferencesValue().getValueString("tokenAssessment");
      if (tokenAssessment != "" && tokenAssessment != null) {
        setState(() {
          GetSurveyPaymentReload(context);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ScreenServer()),
            (Route<dynamic> route) => false,
          );
        });
      } else {
        setState(() {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginAssessment()),
            (Route<dynamic> route) => false,
          );
        });
      }
    });

    super.initState();
  }

  Future<void> GetSurveyPaymentReload(BuildContext context) async {
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
    if (status_code == '200') {
      SurveyList = result;
    } else {
      SurveyList = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/Logo2.png',
                  ),
                  scale: 1.2,
                ),
              ),
              child: CircularProgressIndicator(
                strokeAlign: BorderSide.strokeAlignOutside,
                color: ColorsRedManin,
                backgroundColor: const Color.fromARGB(132, 211, 211, 211),
                strokeWidth: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
