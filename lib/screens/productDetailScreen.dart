import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productProvider.dart';

class ProductDetailScreen extends StatelessWidget{
  static const routeName = "/productDetail";
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    //I created a function 'findById' in the 'productProvider' class
    final loadedProduct = Provider.of<ProductsProvider>(context,listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
