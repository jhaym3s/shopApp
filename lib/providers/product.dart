import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

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

  void toggleFavoritesStatus(){
    //used in the productItem file
    isFavourite = !isFavourite;
    notifyListeners();
  }

}