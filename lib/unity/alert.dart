// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'colors_style.dart';

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
