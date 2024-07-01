// ignore_for_file: avoid_unnecessary_containers, avoid_print, prefer_const_constructors, non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unnecessary_null_comparison, prefer_typing_uninitialized_variables

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
import 'login_scan_payment.dart';

class MainScanPayment extends StatefulWidget {
  const MainScanPayment({super.key});

  @override
  State<MainScanPayment> createState() => _MainScanPaymentState();
}

var ID_PAYMENT;

class _MainScanPaymentState extends State<MainScanPayment> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        GetSurveyPaymentReload(context);
        if (timer.tick >= 3) {
          timer.cancel();
        } else {
          StartTimerA();
        }
      });
    });

    super.initState();
  }

  void StartTimerA() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        Future.delayed(const Duration(seconds: 8), () {
          setState(() {
            initState();
          });
        });
      });
    });
  }

  Future<void> GetSurveyPaymentReload(BuildContext context) async {
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
    if (status_code == '200') {
      SurveyList = result;
    } else {
      SurveyList = "";
    }
    print(result);
  }

  var bill_no = '';
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
                                      bill_no = BilNumber;
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
                                    bill_no = '';
                                  });
                                  print('ยกเลิก');
                                },
                                child: const Text(
                                  'เคลียร์',
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${SurveyList[0]['bill_no']}',
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
                                AlertAssessMentDeleteALL(context);
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
                            SizedBox(
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
                                                  var SurveyListBillNo =
                                                      SurveyList[i]['bill_no'];
                                                  var SurveyListStatus = 9;
                                                  print(
                                                      'ยกเลิก${SurveyList[i]['id']}');
                                                  AlertAssessMentDele(
                                                    context,
                                                    SurveyListBillNo,
                                                    SurveyListStatus,
                                                  );
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

  void AlertAssessMentDele(
      BuildContext context, surveyListBillNo, int surveyListStatus) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Container(
          width: 340,
          height: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 80,
              ),
              Text(
                'ต้องการลบเลขที่ใบเสร็จนี้',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$surveyListBillNo',
                style: TextStyle(
                  fontSize: 45,
                  color: ColorsRedManin,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ใช่หรือไม่',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(155, 50)),
                    onPressed: () {
                      setState(() {
                        Delete_SurveyPayment(
                          context,
                          surveyListBillNo,
                          surveyListStatus,
                        );
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 35,
                        ),
                        Text(
                          ' ยืนยัน',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(155, 50)),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 35,
                        ),
                        Text(
                          ' ยกเลิก',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void AlertAssessMentDeleteALL(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Container(
          width: 340,
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 80,
              ),
              Text(
                'ต้องการลบเลขที่ใบเสร็จทั้งหมด ใช่หรือไม่',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(155, 50)),
                    onPressed: () {
                      setState(() {
                        Delete_SurveyPaymentALL(context);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 35,
                        ),
                        Text(
                          ' ยืนยัน',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(155, 50)),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 35,
                        ),
                        Text(
                          ' ยกเลิก',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AlertDeleteAssessMentDone(BuildContext context) {
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
      Navigator.of(context).pop(); // Close the dialog
      Navigator.of(context).pop(); // Close the dialog
    });
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
          AlertDeleteAssessMentDone(context);
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
          AlertDeleteAssessMentDone(context);
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
        AlertCreateSurveyDone(context);
        print('Done');
        setState(() {
          nameController.clear();
          BilNumber = "";
          GetSurveyPaymentReloadMain(context);
        });
      } else {}
    } catch (e) {
      setState(() {
        AlertCreateSurveyDuprication(context);
      });
      print(e);
      print('ไม่เข้า');
    }
  }

  Future<void> GetSurveyPaymentReloadMain(BuildContext context) async {
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
    if (status_code == '200') {
      setState(() {
        SurveyList = result;
        initState();
      });
    } else {
      SurveyList = "";
    }
    print(result);
  }

  AlertCreateSurveyDone(BuildContext context) {
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
        ),
      ),
    );
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close the dialog
    });
  }

  AlertCreateSurveyDuprication(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Container(
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 100,
                height: 100,
                child: Icon(
                  Icons.error_outline,
                  size: 120,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'พบข้อพิดพลาด',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'เลขที่ใบเสร็จซ้ำ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 70)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  'ยืนยัน',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
