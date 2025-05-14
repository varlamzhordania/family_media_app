import 'dart:convert';
import 'dart:math';

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





  Future<Map<String, dynamic>> getHomePosts(int pageKey) async{
    final userToken =  await _getUserToken();

    try{
      final response = await http.get(
          Uri.parse('$baseUrl/api/posts/?page=$pageKey'),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer $userToken"
          },


      );
      return jsonDecode(response.body);

    }catch(e){
      throw Exception(e);
    }
  }


  Future<Map<String, dynamic>> getSelfPosts(int pageKey) async{
    final userToken =  await _getUserToken();

    try{
      final response = await http.get(
        Uri.parse('$baseUrl/api/posts/self/?page=$pageKey'),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $userToken"
        },

      );
      return jsonDecode(response.body);

    }catch(e){
      throw Exception(e);
    }
  }


  Future<Map<String, dynamic>> getUserDetails() async{
    final userToken =  await _getUserToken();

    try{
      final response = await http.get(
        Uri.parse('$baseUrl/api/accounts/user'),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $userToken"
        },


      );
      return jsonDecode(response.body);

    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getFriendRequests() async{
    final userToken =  await _getUserToken();

    try{
      final response = await http.get(
        Uri.parse('$baseUrl/api/accounts/user/friend-requests/'),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $userToken"
        },
      );


      debugPrint(response.body);

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception("error from server");

      }


    }catch(e){
      throw Exception(e);
    }
  }



  Future<void> likePost(Map<String, dynamic> requestsBody) async{
    final userToken =  await _getUserToken();


    try{
      final response = await http.post(
        Uri.parse('$baseUrl/api/posts/like/'),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $userToken"
        },


        body: jsonEncode(requestsBody)



      );

      debugPrint(
          response.body
      );
    }catch(e){
      throw Exception(e);
    }
  }



  Future<String> friendRequestsAct(Map<String, dynamic> requestsBody, String userID) async{
    final userToken =  await _getUserToken();


    try{
      final response = await http.post(
          Uri.parse('$baseUrl/api/accounts/user/friend-request/$userID/'),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer $userToken"
          },


          body: jsonEncode(requestsBody)



      );


      var decoded = jsonDecode(response.body);

      debugPrint(
          response.body
      );

      return decoded["detail"];



    }catch(e){
      throw Exception(e);
    }
  }


  Future<void> addPost(String familyId, String dec, List<String>? images) async{
    final userToken = await _getUserToken();
    
    var requests = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/posts/'));

    requests.fields['text'] = dec;
    requests.fields['family'] = familyId;

    requests.headers.addAll({
      "Authorization": "Bearer $userToken"
    });

    if (images != null || images!.isNotEmpty){
      images.forEach((action) async{
        var file = await http.MultipartFile.fromPath(
            'media',
            action
        );
        requests.files.add(file);
      });


    }

    try{
      var response = await requests.send();
      debugPrint("status code new post: ${response.statusCode}");
      if(response.statusCode == 201){
        return;
      }else{
        debugPrint("Exception create post: $e");
        throw Exception('Failed to create new post');
      }
    }catch(e){
      throw Exception('$e');

    }

    
    
    
    
    
  }


  Future<Map<String, dynamic>> getComments(int pageKey, int postId) async{
    final userToken =  await _getUserToken();


    try{
      final response = await http.get(
          Uri.parse('$baseUrl/api/posts/comments/?post=$postId&?page=$pageKey'),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer $userToken"
          },
      );

      debugPrint(response.body);


      return jsonDecode(response.body);



    }catch(e){
      throw Exception(e);
    }
  }


  Future<void> addComments(Map<String, dynamic> requestsBody) async{
    final userToken = await _getUserToken();

    try{
      await http.post(
          Uri.parse('$baseUrl/api/posts/comments/'),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer $userToken"
          },


          body: jsonEncode(requestsBody)


      );

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