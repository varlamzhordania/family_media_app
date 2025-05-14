

import 'package:familyarbore/models/friendsRequests/friend_model.dart';
import 'package:familyarbore/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class FriendProvider extends ChangeNotifier{
  bool _is_loading = false;
  bool get is_loading => _is_loading;



  Future<List<FriendModel>> getFriendsRequest() async{
    try{
      _is_loading = true;
      notifyListeners();

      final response = await ApiService().getFriendRequests();


      List<FriendModel> results = [];

      for (var v in response) {
        results.add(FriendModel.fromJson(v));
      }
    
      return results;


    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      throw Exception(e);
    }finally{
      _is_loading = false;
      notifyListeners();
    }


  }




  Future<void> actFriendRequests(String action, String userId) async{

    try{
      _is_loading = true;
      notifyListeners();
      // {"action":"decline"}
      await ApiService().friendRequestsAct({"action":action}, userId);
      notifyListeners();


    }catch(e) {
      throw e.toString();

    }finally{
      _is_loading = false;
      notifyListeners();
    }
  }


}


