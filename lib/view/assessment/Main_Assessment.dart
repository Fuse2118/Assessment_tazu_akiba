// ignore_for_file: avoid_print, non_constant_identifier_names, override_on_non_overriding_member, unused_local_variable

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pushable_button/pushable_button.dart';
import '../../controller/get.dart';
import '../../server/api.dart';
import '../../server/shared_preferences.dart';
import '../../unity/colors_style.dart';
import 'screen_server.dart';

class MainAssessment extends StatefulWidget {
  const MainAssessment({super.key});

  @override
  State<MainAssessment> createState() => _MainAssessmentState();
}

class _MainAssessmentState extends State<MainAssessment> {
  var EvaluationScore;

  @override
  // void initState() {
  //   Timer.periodic(Duration(seconds: 2), (timer) {
  //     GetAssessmentBillReload(context);
  //   });
  //   super.initState();
  // }

  Future<void> GetAssessmentBillReload(BuildContext context) async {
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
      setState(() {
        SurveyList = result;
      });
    } else {
      setState(() {
        SurveyList = "";
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ScreenServer()),
          (Route<dynamic> route) => false,
        );
      });
    }
    print(result);
  }

  void AlertAssessMentDone(BuildContext context) {
    showDialog(
      barrierColor: const Color(0xffED1E24),
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        title: Image.asset(
          'images/thank.jpg',
          scale: 1.1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsRedManin,
        title: const Text(
          'ระดับความพอใจในการบริการวันนี้ ของเรา',
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'เลขที่ใบเสร็จ:',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' ${SurveyList[0]['bill_no']}',
                      style: TextStyle(
                        fontSize: 35,
                        color: ColorsRedManin,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 270,
                            child: PushableButton(
                              height: 270,
                              elevation: 10,
                              hslColor: HSLColor.fromColor(
                                  const Color.fromARGB(255, 48, 48, 48)),
                              shadow: BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(5, 5),
                              ),
                              onPressed: () => AlertAssessMent_Bad(context),
                              child: Image.asset('images/Bad.png'),
                            ),
                          ),
                          SizedBox(
                            width: 270,
                            child: PushableButton(
                              height: 270,
                              elevation: 10,
                              hslColor: HSLColor.fromColor(
                                  const Color.fromARGB(255, 48, 48, 48)),
                              shadow: BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(5, 5),
                              ),
                              onPressed: () {
                                setState(() {
                                  EvaluationScore = 25;
                                  print(EvaluationScore);
                                });
                              },
                              child: Image.asset('images/Medium.png'),
                            ),
                          ),
                          SizedBox(
                            width: 270,
                            child: PushableButton(
                              height: 270,
                              elevation: 10,
                              hslColor: HSLColor.fromColor(
                                  const Color.fromARGB(255, 48, 48, 48)),
                              shadow: BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(5, 5),
                              ),
                              onPressed: () {
                                setState(() {
                                  EvaluationScore = 75;
                                  print(EvaluationScore);
                                });
                              },
                              child: Image.asset('images/Good.png'),
                            ),
                          ),
                          SizedBox(
                            width: 270,
                            child: PushableButton(
                              height: 270,
                              elevation: 10,
                              hslColor: HSLColor.fromColor(
                                  const Color.fromARGB(255, 48, 48, 48)),
                              shadow: BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(5, 5),
                              ),
                              onPressed: () {
                                setState(() {
                                  EvaluationScore = 100;
                                  print(EvaluationScore);
                                });
                              },
                              child: Image.asset('images/VeryGood.png'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: const Color.fromARGB(31, 171, 171, 171)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ColorsRedManin, width: 3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'ข้อเสนอแนะ',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'เพิ่มเติม',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    'images/QrTazu.png',
                    scale: 1.4,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void AlertAssessMent_Bad(BuildContext context) {
    showDialog(
      barrierColor: Color.fromARGB(203, 0, 0, 0),
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorsRedManin,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(250),
                  color: Colors.white),
              child: Image.asset(
                'images/Logo2.png',
                scale: 7,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xffED1E24),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: const Column(
                children: [
                  Text(
                    'ลูกค้าอนุญาตให้ติดต่อกลับหรือไม่',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'เพื่อสอบถามปัญหาที่เกิดขึ้น',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(70),
                    backgroundColor: Colors.green,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide()),
                  ),
                  onPressed: () {
                    setState(() {
                      EvaluationScore = 0;
                      print(EvaluationScore);
                    });
                    print('อนุญาต');
                  },
                  child: const Text(
                    '  อนุญาต  ',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(70),
                    backgroundColor: Colors.red,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide()),
                  ),
                  onPressed: () {
                    EvaluationScore = 0;
                    Navigator.pop(context);
                    print('ไม่อนุญาต');
                    print(EvaluationScore);
                  },
                  child: const Text(
                    'ไม่อนุญาต',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
