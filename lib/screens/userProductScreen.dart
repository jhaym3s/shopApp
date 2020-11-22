import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product_screen.dart';
import '../providers/productProvider.dart';
import '../widgets/userProductItem.dart';
import '../widgets/drawer.dart';
//import 'ordersScreen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/userProductScreen";
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("User Product screen"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, index) =>
              UserProductItem(
                //UserProductItem is a custom made widget
                productData.item[index].id,
              productData.item[index].title,
              productData.item[index].imageUrl),
          itemCount: productData.item.length,
        ),
      ),

    );
  }
}
