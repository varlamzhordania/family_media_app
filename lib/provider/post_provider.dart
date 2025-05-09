
import 'dart:ffi';
import 'package:familyarbore/models/posts/posts_model.dart';
import 'package:familyarbore/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/comments/comment_model.dart';
import '../models/comments/comments_model.dart';

class PostProvider extends ChangeNotifier{
  bool _is_loading = false;

  bool _is_lastPage = false;
  bool _is_lastPage_comment = false;

  bool get is_loading => _is_loading;
  bool get is_lastPage => _is_lastPage;

  bool get is_lastPage_comment => _is_lastPage_comment;


  Future<List<Post>> getHomePost(int pageKey) async{

    try{
      _is_loading = true;
      notifyListeners();

      final response = await ApiService().getHomePosts(pageKey);
      final postModel = PostsModel.fromJson(response);


      _is_lastPage = postModel.next == null ? true : false;


      notifyListeners();

      return postModel.results!;





    }catch(e) {
      Fluttertoast.showToast(msg: e.toString());
      throw e.toString();

    }finally{
      _is_loading = false;
      notifyListeners();
    }
  }



  Future<List<Comments>> getCommentsPost(int pageKey, int postId) async{

    try{
      _is_loading = true;
      notifyListeners();

      final response = await ApiService().getComments(pageKey, postId);
      final commentModel = CommentsModel.fromJson(response);


      _is_lastPage_comment = commentModel.next == null ? true : false;


      notifyListeners();

      return commentModel.results!;





    }catch(e) {
      Fluttertoast.showToast(msg: e.toString());
      throw e.toString();

    }finally{
      _is_loading = false;
      notifyListeners();
    }
  }


  Future<void> likePost(Map<String, dynamic> requestsBody) async{

    try{
      _is_loading = true;
      notifyListeners();

      await ApiService().likePost(requestsBody);
      notifyListeners();


    }catch(e) {
      Fluttertoast.showToast(msg: e.toString());
      throw e.toString();

    }finally{
      _is_loading = false;
      notifyListeners();
    }
  }


  Future<void> addCommentsPost(Map<String, dynamic> requestsBody) async{

    try{
      _is_loading = true;
      notifyListeners();

      final response = await ApiService().addComments(requestsBody);







    }catch(e) {
      Fluttertoast.showToast(msg: e.toString());
      throw e.toString();

    }finally{
      _is_loading = false;
      notifyListeners();
    }
  }




  Future<void> createNewPost(String familyId, String dec, List<String>? images)async{
    try{
      _is_loading = true;
      notifyListeners();


      await ApiService().addPost(familyId, dec, images);
    }catch(e) {
      Fluttertoast.showToast(msg: e.toString());

    }finally{
      _is_loading = false;
      notifyListeners();

    }
  }

}


