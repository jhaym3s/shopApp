import 'package:flutter/material.dart';
import '../providers/cart.dart';
import '../providers/productProvider.dart';
import '../screens/productDetailScreen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    final auth = Provider.of<Auth>(context);
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
            products.isFavourite ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          //toggleFavoritesStatus is in the product.dart file
          product.toggleFavoritesStatus(auth.token,auth.userId);
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
                //addItem used in the card.dart file
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Added ${product.title} to cart"),
                duration: Duration(seconds: 3),
                action: SnackBarAction(label: "Undo", onPressed: (){
                  //removeSingleItem is created in the /provider/cart file
                  cart.removeSingleProduct(product.id);
                }),
                  ),
                );
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
