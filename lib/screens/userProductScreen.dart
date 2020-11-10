import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/productProvider.dart';
import '../widgets/userProductItem.dart';
import 'ordersScreen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/userProductScreen";
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("User Product screen"),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
          })
        ],
      ),
      body: Padding(padding: EdgeInsets.all(8),child:
        ListView.builder(itemBuilder: (context, index) => UserProductItem(productData.item[index].title,
            productData.item[index].imageUrl),
          itemCount:productData.item.length,),),
        drawer: Drawer(
          child: Column(
              children: [
          AppBar(
          title: Text("Hey :)"),
          automaticallyImplyLeading: false,
        ),
              Divider(),
              ListTile(
                  leading: IconButton(icon: Icon(Icons.shop), onPressed: (){
          Navigator.of(context).pushReplacementNamed("/");
        }),
      ),
            Divider(),
            ListTile(
              leading: IconButton(icon: Icon(Icons.payment), onPressed: (){
          Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
        }),
      ),
        ]
          ),
    ),
    );
  }
}
