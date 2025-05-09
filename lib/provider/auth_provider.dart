
import 'package:familyarbore/models/forgotPassword/forgot_model.dart';
import 'package:familyarbore/models/login/login_model.dart';
import 'package:familyarbore/service/api_service.dart';
import 'package:familyarbore/service/sharedPreferences_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_wrap/home_wrap_screen.dart';
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
  bool get is_success => _is_success;
  String get forgotMessage => _forgotMessage;





  Future<void> setUserToken(String _token, String _refresh, String _expirein) async {
    await preferences.setString(ACCESS_TOKEN, _token);
    await preferences.setString(REFRESH_TOKEN, _refresh);
    await preferences.setString(EXPIRE_IN, _expirein);
    await preferences.setBool(LOG_IN, true);


    notifyListeners();


  }




  Future<void> setUserDetails(Map<String, dynamic> detail) async {

    debugPrint("user:  " + detail['user']);
    debugPrint("members:  " + detail['MEMBERSHIP'][0]);

    await preferences.setObject("USER", detail['user']);
    await preferences.setObject("MEMBERSHIP", detail['memberships'][0]);
    notifyListeners();
  }


  Future<void> registerUserReq(Map<String, dynamic> requestBody) async{



    try {
      _is_loading = true;
      notifyListeners();

      final response = await ApiService().registerUser(requestBody);


      _forgotMessage = response;
      _is_success = response.toString().contains("Successful");

      await Future.delayed(Duration(seconds: 5));

      notifyListeners();


    }catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }finally{
      _is_loading = false;
      notifyListeners();
    }


  }


  Future<void> getUserDetail() async{



    try {
      _is_loading = true;
      notifyListeners();

      final response = await ApiService().getUserDetails();
      await setUserDetails(response);

      notifyListeners();


    }catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }finally{
      _is_loading = false;
      notifyListeners();
    }


  }


  Future<void> loginUserReq(Map<String, dynamic> requestBody) async {
    try {
      _is_loading = true;
      notifyListeners();

      final response = await ApiService().loginUser(requestBody);
      LoginModel loginModel = LoginModel.fromJson(response);

      if (response.containsKey("error")) {
        _isAuthenticated = false;
        _hasSeenGetStarted = false;
        notifyListeners();

        Fluttertoast.showToast(msg: response["error_description"]);
      } else {
        // First set the tokens
        await setUserToken(
            loginModel.accessToken.toString(),
            loginModel.refreshToken.toString(),
            loginModel.expiresIn.toString()
        );

        await Future.delayed(Duration(seconds: 1));

        _isAuthenticated = true;
        _hasSeenGetStarted = true;
        await Future.delayed(Duration(seconds: 1));

        notifyListeners();


        Fluttertoast.showToast(msg: "User successfully Login");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      throw(e);
    } finally {
      _is_loading = false;
      notifyListeners();
    }
  }



  Future<void> forgotPasswordReq(Map<String, dynamic> requestBody) async{
    String test = "Password reset link sent to your email";

    try {
      _is_loading = true;
      notifyListeners();


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