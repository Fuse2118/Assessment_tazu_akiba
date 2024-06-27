// ignore_for_file: unused_local_variable, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import '../../controller/get.dart';

class ScreenServer extends StatefulWidget {
  const ScreenServer({super.key});

  @override
  State<ScreenServer> createState() => _ScreenServerState();
}

class _ScreenServerState extends State<ScreenServer> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        GetAssessmentBill(context);
        if (timer.tick >= 3) {
          timer.cancel();
        } else {
          StartTimer();
        }
      });
    });

    super.initState();
  }

  void StartTimer() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        print('  เข้า55555');
        Future.delayed(const Duration(seconds: 8), () {
          setState(() {
            initState();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Carousel(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              indicatorBarColor: Colors.transparent,
              autoScrollDuration: const Duration(seconds: 2),
              animationPageDuration: const Duration(milliseconds: 500),
              unActivatedIndicatorColor: Colors.transparent,
              activateIndicatorColor: Colors.transparent,
              animationPageCurve: Curves.linear,
              stopAtEnd: false,
              autoScroll: true,
              items: [
                Expanded(
                  child: Image.asset(
                    'images/silde1.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'images/silde2.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'images/silde3.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
