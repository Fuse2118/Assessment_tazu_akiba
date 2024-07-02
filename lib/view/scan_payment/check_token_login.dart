// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, avoid_print

import 'package:assessment_tazu_akiba/controller/get.dart';
import 'package:assessment_tazu_akiba/unity/colors_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../server/shared_preferences.dart';
import 'login_scan_payment.dart';

class CheckTokenScanPayment extends StatefulWidget {
  const CheckTokenScanPayment({super.key});

  @override
  State<CheckTokenScanPayment> createState() => _CheckTokenScanPaymentState();
}

class _CheckTokenScanPaymentState extends State<CheckTokenScanPayment> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    Future.delayed(Duration(seconds: 2), () async {
      String gettoken = await SharedPreferencesValue().getValueString("token");
      print(gettoken);
      if (gettoken != "" && gettoken != null) {
        setState(() {
          GetSurveyPayment(context);
        });
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScanPayment()),
          (Route<dynamic> route) => false,
        );
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
