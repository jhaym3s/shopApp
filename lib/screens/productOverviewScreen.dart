import 'package:flutter/material.dart';
import '../providers/productProvider.dart';
import '../widgets/productGrid.dart';
import 'package:provider/provider.dart';

enum filterOptions{
  Favorites,
  All,
}

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        actions: [
          PopupMenuButton(itemBuilder: (context) => [
            PopupMenuItem(child: Text("Favourites Only"),value: filterOptions.Favorites,),
            PopupMenuItem(child: Text("Show all"),value: filterOptions.All,),
          ],onSelected: (filterOptions selectedValue){
            if(selectedValue == filterOptions.Favorites){
              return productData.showFavoriteOnly();
            }else {
              productData.showAll();
            }
          },icon: Icon(Icons.more_vert),)
        ],
      ),
      body: ProductGrid()
    );
  }
}
