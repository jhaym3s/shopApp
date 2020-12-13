
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/models/httpException.dart';

class Auth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String userId;

  bool get isAuth{
    return token != null;
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
      userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    }catch(error){
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return authenticationFunc(email, password, "signUp?key");
  }
   Future<void> login(String email, String password) async{
    return authenticationFunc(email, password, "signInWithPassword?key");
   }

}

