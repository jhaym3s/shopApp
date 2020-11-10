import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cartScreen.dart';
import '../widgets/drawer.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/productGrid.dart';

enum filterOptions {
  Favorites,
  All,
}
class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}
class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var darkMode = false;
  var _showFavouritesOnly  = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bend Down Select"),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Favourites Only"),
                  value: filterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text("Show all"),
                  value: filterOptions.All,
                ),
              ],
              onSelected: (filterOptions selectedValue) {
                setState(() {
                  if (selectedValue == filterOptions.Favorites) {
                    _showFavouritesOnly = true;
                  } else {
                    _showFavouritesOnly = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
            ),
            Consumer<Cart>(
              builder: (context, value, childIconButton) => Badge(
                  child: childIconButton, value: value.itemCount.toString()),
              child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routename);
                  }),
            ),
            IconButton(icon: Icon(darkMode?Icons.wb_sunny_rounded:Icons.nightlight_round), onPressed: (){
              setState(() {
                darkMode = !darkMode;
              });
            }),
          ],
        ),
        drawer: AppDrawer(),
        body: ProductGrid(_showFavouritesOnly),
    backgroundColor: darkMode?Colors.black54:Colors.white,
    );
  }
}
