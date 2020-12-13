import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description ;
  bool isFavourite ;
  final double price ;
  final String imageUrl;

  Product( {
  @required this.id,
  @required this.title,
    @required this.description,
    @ required this.imageUrl,
     this.isFavourite = false,
    @required this.price});

  Future<void> toggleFavoritesStatus(String authToken,String userId) async{
    //used in the productItem file
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = "https://shopapp-f51eb.firebaseio.com/userFavourite/$userId/$id.json?auth=$authToken";
    try {
      final response = await http.put(url, body: json.encode(
         isFavourite,
      ));
      if(response.statusCode >= 400){
        isFavourite = oldStatus;
        notifyListeners();
      }
    }catch(error){
      isFavourite = oldStatus;
      notifyListeners();
    }
  }

}