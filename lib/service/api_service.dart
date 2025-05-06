import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/Constant.dart';

class ApiService {

  Future<String?> getUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(ACCESS_TOKEN);
  }
  
  Future<String?> _getUserToken() async {
    return await getUserToken();
  }
  
  
  Future<String> registerUser(Map<String, dynamic> requestBody) async{
    final response = await http.post(
      Uri.parse('$baseUrl/api/accounts/user/register/'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(requestBody)
      
    );



    debugPrint(response.body);

    if(response.statusCode == 201){
      return "Successful, Verify Email Send To You";

    }else if(response.statusCode == 400){
      return "user with this email address already exists.";

    } else{
      return jsonDecode(response.body);
    }
  }



  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> requestBody) async{
    try{
      final response = await http.post(
          Uri.parse('$baseUrl/api/auth/token/'),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(requestBody)

      );


      debugPrint(response.body);



      return jsonDecode(response.body);

      // if(response.statusCode == 200){
      //
      // }else{
      //   return jsonDecode("Invalid email or password!");
      // }
    }catch(e){
      throw Exception(e);
    }
  }









  Future<String> forgetPasswordUser(Map<String, dynamic> requestBody) async{
    try{
      final response = await http.post(
          Uri.parse('$baseUrl/api/accounts/user/password-reset/'),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(requestBody)

      );


      debugPrint(response.body);

      if(response.statusCode == 200){
        return jsonDecode(response.body)['message'];

      }else if(response.statusCode == 400){
        return "User with this email does not exist.";

      } else{
        return jsonDecode(response.body);
      }


    }catch(e){
      throw Exception(e);
    }
  }
  

}