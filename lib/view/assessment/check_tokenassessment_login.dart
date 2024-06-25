// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, avoid_print

import 'package:assessment_tazu_akiba/controller/get.dart';
import 'package:assessment_tazu_akiba/unity/colors_style.dart';
import 'package:assessment_tazu_akiba/view/assessment/login_assessment.dart';
import 'package:flutter/material.dart';

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
    Future.delayed(Duration(seconds: 2), () async {
      String gettoken =
          await SharedPreferencesValue().getValueString("tokenAssessment");
      print(gettoken);
      if (gettoken != "" && gettoken != null) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  scale: 5,
                  image: AssetImage(
                    'images/Logo2.png',
                  ),
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
