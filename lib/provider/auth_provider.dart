
import 'package:familyarbore/models/forgotPassword/forgot_model.dart';
import 'package:familyarbore/models/login/login_model.dart';
import 'package:familyarbore/service/api_service.dart';
import 'package:familyarbore/service/sharedPreferences_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import '../utils/Constant.dart';

class AuthProvider with ChangeNotifier {

  final SharedPreferencesService preferences =
  GetIt.instance<SharedPreferencesService>();


  bool _isAuthenticated = false;
  bool _hasSeenGetStarted = false;
  bool _isChecking = true;
  bool _is_loading = false;
  bool _is_success = false;

  String _forgotMessage = "";



  bool get isAuthenticated => _isAuthenticated;
  bool get hasSeenGetStarted => _hasSeenGetStarted;
  bool get isChecking => _isChecking;
  bool get is_loading => _is_loading;
  String get forgotMessage => _forgotMessage;

  bool get is_success => _is_success;





  Future<void> setUserToken(String _token, String _refresh, String _expirein) async {
    await preferences.setString(ACCESS_TOKEN, _token);
    await preferences.setString(REFRESH_TOKEN, _refresh);
    await preferences.setString(EXPIRE_IN, _expirein);
    await preferences.setBool(LOG_IN, true);


  }

  Future<void> registerUserReq(Map<String, dynamic> requestBody) async{

    try {
      final response = await ApiService().registerUser(requestBody);

      if(response.isNotEmpty){

      }
    }catch (e) {
      throw e;
    }

  }


  Future<String> loginUserReq(Map<String, dynamic> requestBody) async{

    try {
      _is_loading = true;

      final response = await ApiService().loginUser(requestBody);
      LoginModel loginModel = LoginModel.fromJson(response);


      setUserToken(loginModel.accessToken.toString(),
          loginModel.refreshToken.toString(),
          loginModel.expiresIn.toString()
      );
      notifyListeners();
      return "User successfully Login";




    }catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      throw(e);
    }finally{
      _is_loading = false;
      notifyListeners();
    }

  }

  Future<void> forgotPasswordReq(Map<String, dynamic> requestBody) async{
    String test = "Password reset link sent to your email";

    try {
      _is_loading = true;

      final response = await ApiService().forgetPasswordUser(requestBody);


      _forgotMessage = response;


      _is_success = response.toString().contains("sent");


      debugPrint(_forgotMessage);

      notifyListeners();




    }catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      throw(e);
    }finally{
      _is_loading = false;
      notifyListeners();
    }

  }



  Future<void> onAppStart() async {
    _isChecking = true;
    notifyListeners();
    _isAuthenticated = await preferences.getBool(LOG_IN);
    _hasSeenGetStarted = await preferences.getBool(FIRST_TIME);
    _isChecking = false;
    notifyListeners();
  }


  Future<void> markGetStartSeen() async {
    await preferences.setBool(FIRST_TIME, true);
    _hasSeenGetStarted = true;
    debugPrint("markGetStartSeen: true");
    notifyListeners();
  }



  Future<void> logout() async {
    await preferences.setBool(LOG_IN, false);
    await preferences.setString(ACCESS_TOKEN, "");
    await preferences.setString(REFRESH_TOKEN, "");
    await preferences.setString(EXPIRE_IN, "");

    _isAuthenticated = false;
    debugPrint("logout: true");

    notifyListeners();
  }

}