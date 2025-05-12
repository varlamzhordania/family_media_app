
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/member/member_model.dart';

class SharedPreferencesService {

  Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }




  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }



  Future<Map<String, dynamic>> getObject(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key) ?? "";
    return jsonDecode(data);
  }

  Future<void> setObject(String key,  Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(value));
  }


  Future<void> setMemberObject(String key,  List<MemberModel> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(value));
  }



  Future<List<MemberModel>> getMemberObject(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key) ?? "";
    var jdMember = jsonDecode(data);
    List<MemberModel> listMember = [];

    if (jdMember != null) {
      jdMember.forEach((v) {
        listMember.add(MemberModel.fromJson(v));
      });
    }
    return listMember;
  }



}