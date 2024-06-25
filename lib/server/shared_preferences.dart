// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_string_interpolations

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesValue {
  // get String ---------------------------------------------------------------
  Future<String> getValueString(String _key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('$_key') ?? "";
    return value;
  }

  // set String
  setValueString(String _key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$_key', value);
  }

  // get Bool -----------------------------------------------------------------
  Future<bool> getValueBool(String _key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('$_key') ?? false;
    return value;
  }

  // set Bool
  setValueBool(String _key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$_key', value);
  }

  // set int
  setValueInt(String _key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('$_key', value);
  }

  // delete shared_preferences ------------------------------------------------
  delValue(String _key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('$_key');
  }
}
