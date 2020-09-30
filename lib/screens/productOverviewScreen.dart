import 'package:flutter/material.dart';
import '../providers/productProvider.dart';
import '../widgets/productGrid.dart';
import 'package:provider/provider.dart';

enum filterOptions{
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavouritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        actions: [
          PopupMenuButton(itemBuilder: (context) => [
            PopupMenuItem(child: Text("Favourites Only"),value: filterOptions.Favorites,),
            PopupMenuItem(child: Text("Show all"),value: filterOptions.All,),
          ],onSelected: (filterOptions selectedValue){
            setState(() {
              if(selectedValue == filterOptions.Favorites){
                _showFavouritesOnly = true;
              }else {
                _showFavouritesOnly = false;
              }
            });
          },icon: Icon(Icons.more_vert),)
        ],
      ),
      body: ProductGrid(_showFavouritesOnly)
    );
  }
}
