import 'package:flutter/cupertino.dart';

class Product{
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

}