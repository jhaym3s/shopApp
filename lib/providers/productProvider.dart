import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _item = [
    // Product(
    //   id: 'p1',
    //   title: 'Cactus',
    //   description: 'A domestic Cactus',
    //   price: 29.99,
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1504648492881-a5150829085c?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mjh8fHxlbnwwfHx8&auto=format&fit=crop&w=500&q=60.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'A flower',
    //   description: 'A nice flower',
    //   price: 59.99,
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHw%3D&auto=format&fit=crop&w=500&q=60.png',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'A Camera',
    //   description: 'Dope ass camera',
    //   price: 19.99,
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1521499892833-773a6c6fd0b8?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8N3x8fGVufDB8fHw%3D&auto=format&fit=crop&w=500&q=60.png',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Doors',
    //   description: 'Get a classic door of any color for yourself.',
    //   price: 49.99,
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1543005240-6a7dcea5bfca?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTJ8fHxlbnwwfHx8&auto=format&fit=crop&w=500&q=60.png',
    // ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get item {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._item];
  }

  List<Product> get favoriteItems {
    return _item.where((prodItem) => prodItem.isFavourite).toList();
  }

  Product findById(String id) {
    return _item.firstWhere((prod) => prod.id == id);
  }
  Future<void> fetchAndSetProducts() async {
    const url = "https://shopapp-f51eb.firebaseio.com/productProvider.json";
    try {
      final response = await http.get(url);
     //print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _item = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
  Future <void> addProduct(Product product) async {
    const url = "https://shopapp-f51eb.firebaseio.com/productProvider.json";
    try {
      final response = await http.post(url,
        body: json.encode({
        "title": product.title,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavourite": product.isFavourite,
      }),);
      print(jsonDecode(response.body));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: jsonDecode(response.body)["name"],
      );
      _item.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    }catch (error){
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async{
    final prodIndex = _item.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = "https://shopapp-f51eb.firebaseio.com/productProvider/$id.json";
       await http.patch(url,
        body: json.encode({
          "title": newProduct.title,
          "description": newProduct.description,
          "price":newProduct.price,
          "imageUrl": newProduct.imageUrl,
         // "isFavourite": newProduct.isFavourite,
        }),);
      _item[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  //ignore: missing_return
  Future<void> deleteProduct(String id) {
    final url = "https://shopapp-f51eb.firebaseio.com/productProvider/$id.json";
    final existingProductIndex = _item.indexWhere((prod) => prod.id == id);
    var existingProduct = _item[existingProductIndex];
    _item.removeAt(existingProductIndex);
    notifyListeners();

    http.delete(url).then((response) {
      existingProduct = null;
      print(response.statusCode);
      if(response.statusCode >= 400){
        throw HttpException("Wahala ooooo");
      }
    } ).catchError((_){
      _item.insert(existingProductIndex, existingProduct);
    });
    _item.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
