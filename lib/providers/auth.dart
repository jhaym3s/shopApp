
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/models/httpException.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth{
    return token != null;
  }
  String get userId{
    return _userId;
  }

  String get token{
    if(_expiryDate != null && _expiryDate.isAfter(DateTime.now())&&_token!= null){
      return _token;
    }
    return null;
  }
  Future<void> authenticationFunc(String email, String password, String urlDifference)async{
    final url = "https://identitytoolkit.googleapis.com/v1/accounts:$urlDifference=AIzaSyAU5yYvKhtVN2xx82fjflGHk4fxHeMFAyg";
    try{
      final response =  await http.post(url,body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }));
      print(json.decode(response.body));
      final responseData = json.decode(response.body) ;
      if(responseData["error"] != null){
        throw HttpException(responseData["error"]["message"]);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      autoLogout();
      notifyListeners();
      final preferences = await SharedPreferences.getInstance();
     var userData =  json.encode({
        "token":_token,
       "expiryDate":_expiryDate.toIso8601String(),
       "userId":_userId,
      });
      preferences.setString("userData", userData);
    }catch(error){
      throw error;
    }
  }
  Future<bool> tryAutoLogin()async{
    final preferences = await SharedPreferences.getInstance();
    if(!preferences.containsKey("userData")){
      return false;
    }
    final extractedData = json.decode(preferences.getString("userData"))as Map<String, Object>;
    final newExpiryDate =DateTime.parse(extractedData["expiryDate"]);
    if(newExpiryDate.isBefore(DateTime.now())){
      return false;
    }
    _userId = extractedData["userId"];
    _expiryDate = newExpiryDate;
    _token = extractedData["token"];
    notifyListeners();
    autoLogout();
    //_userId = extractedData["userId"];
    return true;
  }

  Future<void> signUp(String email, String password) async {
    return authenticationFunc(email, password, "signUp?key");
  }
   Future<void> login(String email, String password) async{
    return authenticationFunc(email, password, "signInWithPassword?key");
   }

   Future<void> logout()async{
    _expiryDate= null;
    _token = null;
    _userId = null;
    if (_authTimer!=null){
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final preferences = await SharedPreferences.getInstance();
    preferences.remove("userData");
    preferences.clear();

   }
   void autoLogout(){
    if (_authTimer!=null){
      _authTimer.cancel();
    }
    final expiryTime = _expiryDate.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: expiryTime), logout);
   }


}

