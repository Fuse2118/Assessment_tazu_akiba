// ignore_for_file: avoid_print, non_constant_identifier_names, override_on_non_overriding_member, unused_local_variable, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

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
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      GetSurveyReload(context);
      if (timer.tick >= 5) {
        timer.cancel();
      }
    });
    super.initState();
  }

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
        Timer.periodic(Duration(seconds: 3), (timer) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ScreenServer()),
            (Route<dynamic> route) => false,
          );
        });
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
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        GetSurveyReload(context);
        Navigator.of(context).pop(); // Close the dialog
      });
    });
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
                              onPressed: () {
                                setState(() {
                                  AlertAssessMent_Bad(context);
                                });
                              },
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
                                  var EvaluationScore = 25;
                                  var SurveyListBillNo =
                                      SurveyList[0]['bill_no'];
                                  var Company_Id = SurveyList[0]['user_id'];
                                  var surveyListStatus = 1;
                                  var Contact_Back = 0;
                                  AssessmentEvaluationScore(
                                    context,
                                    SurveyListBillNo,
                                    surveyListStatus,
                                    Company_Id,
                                    EvaluationScore,
                                    Contact_Back,
                                  );
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
                                  var EvaluationScore = 75;
                                  var SurveyListBillNo =
                                      SurveyList[0]['bill_no'];
                                  var Company_Id = SurveyList[0]['user_id'];
                                  var surveyListStatus = 1;
                                  var Contact_Back = 0;
                                  AssessmentEvaluationScore(
                                    context,
                                    SurveyListBillNo,
                                    surveyListStatus,
                                    Company_Id,
                                    EvaluationScore,
                                    Contact_Back,
                                  );
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
                                  var EvaluationScore = 100;
                                  var SurveyListBillNo =
                                      SurveyList[0]['bill_no'];
                                  var Company_Id = SurveyList[0]['user_id'];
                                  var surveyListStatus = 1;
                                  var Contact_Back = 0;
                                  AssessmentEvaluationScore(
                                    context,
                                    SurveyListBillNo,
                                    surveyListStatus,
                                    Company_Id,
                                    EvaluationScore,
                                    Contact_Back,
                                  );
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

  void AlertAssessMent_Bad(
    BuildContext context,
  ) {
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
                      var SurveyListBillNo = SurveyList[0]['bill_no'];
                      var Company_Id = SurveyList[0]['user_id'];
                      var EvaluationScore = 0;
                      var surveyListStatus = 1;
                      var Contact_Back = 1;
                      AssessmentEvaluationScore(
                        context,
                        SurveyListBillNo,
                        surveyListStatus,
                        Company_Id,
                        EvaluationScore,
                        Contact_Back,
                      );
                    });
                    Navigator.pop(context);
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
                    setState(() {
                      var SurveyListBillNo = SurveyList[0]['bill_no'];
                      var Company_Id = SurveyList[0]['user_id'];
                      var EvaluationScore = 0;
                      var surveyListStatus = 1;
                      var Contact_Back = 0;
                      AssessmentEvaluationScore(
                        context,
                        SurveyListBillNo,
                        surveyListStatus,
                        Company_Id,
                        EvaluationScore,
                        Contact_Back,
                      );
                      Navigator.pop(context);
                    });
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

  Future<void> AssessmentEvaluationScore(
    BuildContext context,
    SurveyListBillNo,
    int surveyListStatus,
    company_id,
    int evaluationScore,
    int contact_back,
  ) async {
    String gettoken = await SharedPreferencesValue().getValueString("token");
    String url = '${Api_UpdateSurveyStatus}';
    Dio dio = Dio();
    print(SurveyListBillNo);
    print(company_id);
    print(surveyListStatus);
    print(evaluationScore);
    print(contact_back);
    try {
      Response response = await dio.put(
        options: Options(headers: {'Authorization': 'Bearer $gettoken'}),
        url,
        data: {
          "bill_no": SurveyListBillNo.toString(),
          "score": evaluationScore,
          "contact_back": contact_back.toString(),
          "user_id": company_id,
          "status": surveyListStatus.toString()
        },
      );

      var result = response.data["results"];
      print(result);
      var status_code = response.data["status_code"][0]['code'];
      if (status_code == "200") {
        setState(() {
          GetSurveyReload(context);
          AlertAssessMentDone(context);
          initState();
          setState(() {
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                GetSurveyReload(context);
              });
            });
          });
        });
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Future<void> GetSurveyReload(BuildContext context) async {
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
    if (result != null) {
      setState(() {
        SurveyList = result;
      });
    } else {
      setState(() {
        SurveyList = null;
        GetAssessmentBillReload(context);
      });
    }
    print(result);
  }
}
