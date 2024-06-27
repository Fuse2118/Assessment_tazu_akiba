import 'package:assessment_tazu_akiba/view/assessment/login_assessment.dart';
import 'package:flutter/material.dart';

import 'view/assessment/check_tokenassessment_login.dart';
import 'view/scan_payment/check_token_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const CheckTokenScanPayment(),
      home: const CheckTokenAssessment(),
    );
  }
}
