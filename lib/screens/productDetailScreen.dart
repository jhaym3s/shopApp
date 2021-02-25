import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productProvider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/productDetail";
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    //I created a function 'findById' in the 'productProvider' class
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    //the findById was made in the productProvider class
    //Okay you can do the below or the above
    //final loadedProduct = Provider.of<ProductsProvider>(context).item.firstWhere((product) => product.id == productId );
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              child: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${loadedProduct.price}",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
                child: Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            )),
          ],
        ),
      ),
    );
  }
}
