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
      GetAssessmentBillReload(context);
    });
    super.initState();
  }

  Future<void> GetAssessmentBillReload(BuildContext context) async {
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
          scale: 1.2,
        ),
      ),
    );
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        GetAssessmentBillReload(context);
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
          if (SurveyList != null && SurveyList != "") ...{
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
                              width: 200,
                              child: PushableButton(
                                height: 200,
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
                              width: 200,
                              child: PushableButton(
                                height: 200,
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
                              width: 200,
                              child: PushableButton(
                                height: 200,
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
                              width: 200,
                              child: PushableButton(
                                height: 200,
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
                                    // AlertAssessmentBillDone(context);
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'images/QrTazu.png',
                        scale: 1.4,
                      ),
                    )
                  ],
                ),
              ),
            ),
          } else ...{
            Container(
              color: Colors.white,
            )
          }
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
              width: MediaQuery.of(context).size.width * 0.4,
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
    String tokenAssessment =
        await SharedPreferencesValue().getValueString("tokenAssessment");
    String url = '${Api_UpdateSurveyStatus}';
    Dio dio = Dio();

    try {
      Response response = await dio.put(
        options: Options(headers: {'Authorization': 'Bearer $tokenAssessment'}),
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
          GetAssessmentBillReload(context);
          AlertAssessmentBillDone(context);
          initState();
          setState(() {
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                GetAssessmentBillReload(context);
              });
            });
          });
        });
      } else {}
    } catch (e) {
      print(e);
    }
  }

  AlertAssessmentBillDone(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Container(
            width: 340,
            height: 320,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: ColorsRedManin,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'กรุณารอสักครู่....',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )),
    );
    Future.delayed(Duration(seconds: 2), () {
      AlertAssessMentDone(context);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Close the dialog
      });
    });
  }
}
