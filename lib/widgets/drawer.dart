import 'package:flutter/material.dart';
import 'package:shop/screens/ordersScreen.dart';
// this was used in the product overview scree
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
        ],
      ),
    );
  }
}
