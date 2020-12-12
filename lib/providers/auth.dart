
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop/models/httpException.dart';

class Auth with ChangeNotifier{
  String token;
  DateTime expiryDate;
  String userId;

  
  Future<void> authenticationFunc(String email, String password, String urlDifference)async{
    final  url = "https://identitytoolkit.googleapis.com/v1/accounts:$urlDifference=AIzaSyAU5yYvKhtVN2xx82fjflGHk4fxHeMFAyg";
    try{
      final response =  await http.post(url,body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }));
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if(responseData["error"] != null){
        throw HttpException(responseData["error"]["message"]);
      }
    }catch(error){
      throw error;
    }

  }
  

  Future<void> signUp(String email, String password) async {
    return authenticationFunc(email, password, "signUp?key");
  //   const url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAU5yYvKhtVN2xx82fjflGHk4fxHeMFAyg";
  // final response =  await http.post(url,body: json.encode({
  //   "email": email,
  //   "password": password,
  //   "returnSecureToken": true,
  // }));
  // print(json.decode(response.body));
  }
   Future<void> login(String email, String password) async{
    return authenticationFunc(email, password, "signInWithPassword?key");
    // const url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAU5yYvKhtVN2xx82fjflGHk4fxHeMFAyg";
    // final response = await http.post(url,body: json.encode({
    //   "email":email,
    //   "password":email,
    //   "returnSecureToken": true,
    // }));
    // print(json.decode(response.body));

    //you could also extract this functions and make a variable out of them
   }

}

