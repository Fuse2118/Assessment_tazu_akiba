// ignore_for_file: must_call_super, non_constant_identifier_names, prefer_typing_uninitialized_variables, sized_box_for_whitespace, prefer_const_constructors, annotate_overrides

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/post.dart';
import '../../server/api.dart';
import 'screen_server.dart';

class LoginAssessment extends StatefulWidget {
  const LoginAssessment({super.key});

  @override
  State<LoginAssessment> createState() => _LoginAssessmentState();
}

class _LoginAssessmentState extends State<LoginAssessment> {
  var TextUsername;
  var TextPassword;
  bool hidePassword = true;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    TextUsername = "";
    TextPassword = "";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromARGB(255, 136, 11, 11),
            Color.fromARGB(255, 136, 11, 11),
            Colors.white,
          ])),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "เข้าสู่ระบบ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "สำหรับแบบประเมิน",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "ความพึงพอใจของลูกค้า",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeInUp(
                              duration: const Duration(
                                milliseconds: 1000,
                              ),
                              child: Image.asset(
                                'images/Logo2.png',
                              )),
                          const SizedBox(
                            height: 60,
                          ),
                          Container(
                            width: 550,
                            child: FadeInUp(
                                duration: const Duration(milliseconds: 1400),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(127, 136, 11, 11),
                                          blurRadius: 20,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                        child: TextField(
                                          onChanged: (username) {
                                            setState(() {
                                              TextUsername = username;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: "ชื่อผู้ใช้งาน",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200),
                                          ),
                                        ),
                                        child: TextField(
                                          onChanged: (password) {
                                            setState(() {
                                              TextPassword = password;
                                            });
                                          },
                                          obscureText:
                                              hidePassword, //show/hide password
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: hidePassword
                                                  ? const Icon(
                                                      Icons.visibility_off)
                                                  : const Icon(
                                                      Icons.visibility,
                                                      color: Color.fromARGB(
                                                        255,
                                                        136,
                                                        11,
                                                        11,
                                                      ),
                                                    ),
                                              onPressed: () {
                                                (context as Element)
                                                    .markNeedsBuild();
                                                hidePassword = !hidePassword;
                                              },
                                            ),
                                            hintText: "รหัสผ่าน",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          if (TextUsername != "" && TextPassword != "") ...{
                            FadeInUp(
                              duration: const Duration(milliseconds: 1600),
                              child: LoadingBtn(
                                width: 250,
                                height: 60,
                                disabledColor: Colors.grey,
                                borderRadius: 8,
                                roundLoadingShape: false,
                                color: const Color.fromARGB(255, 136, 11, 11),
                                disabledTextColor: Colors.green,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.30,
                                loader: const Text(
                                  "กรุณารอสักครู่...",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text(
                                  "เข้าสู่ระบบ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: (startLoading, stopLoading,
                                    btnState) async {
                                  if (btnState == ButtonState.idle) {
                                    startLoading();
                                    setState(() {
                                      if (TextUsername != "" &&
                                          TextPassword != "") {
                                        PostLoginAssessment(
                                          context,
                                          TextUsername,
                                          TextPassword,
                                        );

                                        // PostLoginTablet(
                                        //     context, TextUsername, TextPassword);
                                      }
                                    });
                                    await Future.delayed(
                                      const Duration(seconds: 2),
                                    );
                                    stopLoading();
                                  }
                                },
                              ),
                            ),
                          } else ...{
                            FadeInUp(
                              duration: const Duration(milliseconds: 1600),
                              child: LoadingBtn(
                                width: 250,
                                height: 60,
                                disabledColor: Colors.grey,
                                borderRadius: 8,
                                roundLoadingShape: false,
                                color: Colors.grey,
                                disabledTextColor: Colors.green,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.30,
                                loader: const Text(
                                  "กรุณารอสักครู่...",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text(
                                  "เข้าสู่ระบบ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: (startLoading, stopLoading, btnState) =>
                                    null,
                              ),
                            ),
                          },
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String tokenAssessment = "";
  bool _isChecked_Assessment_Login = true;
  Future<void> PostLoginAssessment(
    BuildContext context,
    textUsername,
    textPassword,
  ) async {
    String url = Api_Login;
    Dio dio = Dio();
    print(url);
    try {
      Response response = await dio.post(
        url,
        data: {
          "username": textUsername.toString(),
          "password": textPassword.toString(),
        },
      );

      var result = response.data["results"];
      print(result);
      var status_code = response.data["status_code"][0]['code'];
      Company_Id = result['id'];
      print(status_code);
      if (status_code == "200") {
        setState(() {
          tokenAssessment = result['token'];
          RememberPreferencesAssessment(_isChecked_Assessment_Login);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ScreenServer()),
              (Route<dynamic> route) => false);
        });
      } else {}
    } catch (e) {
      print(e);
      print('ไม่เข้า');
    }
  }

  void RememberPreferencesAssessment(value) {
    _isChecked_Assessment_Login = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('tokenAssessment', tokenAssessment);
        prefs.setString('Company_Id', Company_Id);
      },
    );
    void setState(value) {
      _isChecked_Assessment_Login = value;
      tokenAssessment;
    }
  }
}
