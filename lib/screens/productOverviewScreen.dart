import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';
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
  static const routeName =" productOverViewScreen";
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}
class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var darkMode = false;
  var _showFavouritesOnly  = false;
  var _isInit = true;
  var isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          isLoading = false;
        });
      }).catchError((error){
        return showDialog(context: context,builder: (context) {
          return AlertDialog(
            title: Text(" An error occurred"),
            content: Text("Check your internet connection"),
            actions: [
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Okay"))
            ],
          );
        },);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
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
