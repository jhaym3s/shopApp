import 'package:flutter/material.dart';
import 'package:shop/screens/ordersScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("What you are thinking now"),
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
