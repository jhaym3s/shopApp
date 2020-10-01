import 'package:flutter/material.dart';
import '../providers/cart.dart';
import '../providers/productProvider.dart';
import '../screens/productDetailScreen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String imageUrl;
  // final String id;
  // final String title;
  //
  // ProductItem(this.imageUrl, this.id, this.title);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
          footer: GridTileBar(
            leading: Consumer<Product>(
    builder: (BuildContext context, products, Widget child) {
      return IconButton(
        icon: Icon(
            product.isFavourite ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          product.toggleFavoritesStatus();
        },
        color: Theme
            .of(context)
            .accentColor,
      );
          }
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
              },
              color: Theme.of(context).accentColor,
            ),
            backgroundColor: Colors.black54,
            title:  Text(product.title)
        ),
      ),
    );
  }
}
