// ignore_for_file: avoid_unnecessary_containers, avoid_print, prefer_const_constructors, non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unnecessary_null_comparison

import 'dart:async';

import 'package:assessment_tazu_akiba/controller/get.dart';
import 'package:assessment_tazu_akiba/unity/colors_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pushable_button/pushable_button.dart';
import '../../controller/post.dart';
import '../../server/api.dart';
import '../../server/shared_preferences.dart';
import '../assessment/screen_server.dart';
import 'login_scan_payment.dart';

class MainScanPayment extends StatefulWidget {
  const MainScanPayment({super.key});

  @override
  State<MainScanPayment> createState() => _MainScanPaymentState();
}

var ID_PAYMENT;

class _MainScanPaymentState extends State<MainScanPayment> {
  // void initState() {
  //   Timer.periodic(Duration(seconds: 2), (timer) {
  //     setState(() {
  //       GetSurveyPaymentReload(context);
  //     });
  //   });

  //   super.initState();
  // }

  TextEditingController nameController = TextEditingController();
  String BilNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              color: ColorsRedManin,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: const Image(
                          width: 250,
                          image: AssetImage('images/Logo2.png'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Row(
                          children: const [
                            Text(
                              'เลขที่ใบเสร็จ',
                              style: TextStyle(
                                fontSize: 45,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: MediaQuery.of(context).size.width * 0.41,
                              padding: EdgeInsets.all(20),
                              child: TextField(
                                style: TextStyle(fontSize: 55),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                cursorColor: ColorsRedManin,
                                maxLength: 10,
                                controller: nameController,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    BilNumber = text;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (BilNumber != null &&
                                BilNumber != '' &&
                                nameController.text.length == 10) ...{
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      var datetime = DateTime.now();
                                      var bill_no = BilNumber;
                                      var Status_Assessment = 0;
                                      print(
                                          '${datetime.year}-${datetime.month}-${datetime.day}');
                                      print(ID_PAYMENT);
                                      PostCreateSurvey(context, datetime,
                                          bill_no, Status_Assessment);
                                    });
                                  },
                                  child: const Text(
                                    'ยืนยัน',
                                    style: TextStyle(
                                        fontSize: 45, color: Colors.white),
                                  ),
                                ),
                              ),
                            } else ...{
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: null,
                                  child: const Text(
                                    'ยืนยัน',
                                    style: TextStyle(
                                        fontSize: 45, color: Colors.white),
                                  ),
                                ),
                              ),
                            },
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.10,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    nameController.clear();
                                    BilNumber = "";
                                  });
                                  print('ยกเลิก');
                                },
                                child: const Text(
                                  'ยกเลิก',
                                  style: TextStyle(
                                    fontSize: 45,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: PushableButton(
                      height: 60,
                      elevation: 10,
                      hslColor: HSLColor.fromColor(ColorsRedManin),
                      shadow: BoxShadow(
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.4),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                      onPressed: () {
                        setState(() {
                          SharedPreferencesValue().delValue("token");
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScanPayment()),
                            (Route<dynamic> route) => false,
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              'ออกจากระบบ  ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.logout,
                              size: 45,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (SurveyList != null && SurveyList != '') ...{
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'เลขที่ใบเสร็จ',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // '${SurveyList[0]['bill_no']}',
                            '$BilNumber',
                            style: TextStyle(
                              fontSize: 65,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ประเมินความพึงพอใจ',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                Delete_SurveyPaymentALL(context);
                              });
                              print('ลบทั้งหมด');
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'ลบทั้งหมด',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 400,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: DataTable(
                                headingTextStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                dataTextStyle: const TextStyle(
                                  fontSize: 18,
                                ),
                                border: TableBorder.all(),
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      '     ลำดับ',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '    เลขที่ใบเสร็จ',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '       สถานะ',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '      ยกเลิก',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                                rows: <DataRow>[
                                  for (int i = 0;
                                      i < SurveyList.length;
                                      i++) ...{
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(
                                          Center(
                                            child: Text('${i + 1}    '),
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                            child: Text(
                                              '${SurveyList[i]['bill_no']}',
                                            ),
                                          ),
                                        ),
                                        if (SurveyList[i]['status'] == '0') ...{
                                          DataCell(
                                            Center(
                                              child: Text(
                                                'รอประเมิน ',
                                                style: TextStyle(
                                                  color: Colors.blue.shade900,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        } else
                                          ...{},
                                        DataCell(
                                          Center(
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  // var SurveyListBillNo =
                                                  //     SurveyList[i]['bill_no'];
                                                  // var SurveyListStatus = 9;
                                                  // Delete_SurveyPayment(
                                                  //     context,
                                                  //     SurveyListBillNo,
                                                  //     SurveyListStatus);
                                                  // print(
                                                  //     'ยกเลิก${SurveyList[i]['id']}');
                                                  AlertAssessMentDele(context);
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  }
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          } else ...{
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_late_outlined,
                      color: ColorsRedManin,
                      size: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ไม่พบข้อมูลเลขที่ใบเสร็จ',
                      style: TextStyle(
                        fontSize: 45,
                      ),
                    )
                  ],
                ),
              ),
            ),
          }
        ],
      ),
    );
  }

  void AlertAssessMentDele(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Container(
          width: 250,
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: ColorsRedManin,
                ),
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
        ),
      ),
    );
  }

  Future<void> Delete_SurveyPayment(
    BuildContext context,
    SurveyListBillNo,
    int surveyListStatus,
  ) async {
    String gettoken = await SharedPreferencesValue().getValueString("token");
    String url = '${Api_UpdateSurveyStatus}';
    Dio dio = Dio();

    try {
      Response response = await dio.put(
        options: Options(headers: {'Authorization': 'Bearer $gettoken'}),
        url,
        data: {
          "bill_no": SurveyListBillNo.toString(),
          "score": null,
          "contact_back": "1",
          "user_id": Company_Id,
          "status": surveyListStatus.toString()
        },
      );

      var result = response.data["results"];
      print(result);
      var status_code = response.data["status_code"][0]['code'];
      if (status_code == "200") {
        setState(() {
          GetSurveyPaymentReload(context);
          setState(() {
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                GetSurveyPaymentReload(context);
              });
            });
          });
        });
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Future<void> Delete_SurveyPaymentALL(
    BuildContext context,
  ) async {
    String gettoken = await SharedPreferencesValue().getValueString("token");
    String url = '${Api_DeleteSurveyPaymentALL}';
    Dio dio = Dio();

    try {
      Response response = await dio.delete(
        options: Options(headers: {'Authorization': 'Bearer $gettoken'}),
        url,
      );

      var result = response.data["results"];
      print(result);
      var status_code = response.data["status_code"][0]['code'];
      if (status_code == "200") {
        setState(() {
          GetSurveyPaymentReload(context);
          setState(() {
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                GetSurveyPaymentReload(context);
              });
            });
          });
        });
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Future<void> PostCreateSurvey(
    BuildContext context,
    DateTime datetime,
    String bill_no,
    int status_assessment,
  ) async {
    String url = Api_PostCreateSurvey;
    Dio dio = Dio();
    String gettoken = await SharedPreferencesValue().getValueString("token");
    print(url);
    try {
      Response response = await dio.post(
        options: Options(headers: {'Authorization': 'Bearer $gettoken'}),
        url,
        data: {
          "date": datetime.toString(),
          "bill_no": bill_no.toString(),
          "score": null,
          "contact_back": "1",
          "user_id": Company_Id,
          "status": status_assessment.toString()
        },
      );

      var result = response.data["results"];

      var status_code = response.data["status_code"][0]['code'];
      print(result);
      print(status_code);
      if (status_code == "200") {
        print('Done');
        nameController.clear();
        BilNumber = "";
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => const MainScanPayment()),
        //     (Route<dynamic> route) => false);
      } else {}
    } catch (e) {
      // AlertUserPassworNullFall(context);
      print(e);
      print('ไม่เข้า');
    }
  }
}
