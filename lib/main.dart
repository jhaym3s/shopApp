import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/orders.dart';
import './screens/cartScreen.dart';
import './screens/ordersScreen.dart';
import './screens/userProductScreen.dart';
import './providers/cart.dart';
import './screens/productDetailScreen.dart';
import './screens/productOverviewScreen.dart';
import './providers/productProvider.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider(),),
        ChangeNotifierProvider(create: (context) => Auth(),),
        ChangeNotifierProvider(create: (context) => Cart(),),
        ChangeNotifierProvider(create: (context) => Orders(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Lato",
          primaryColor: Colors.purple,
          accentColor: Colors.purpleAccent,
          //accentColorBrightness: Brightness.dark,
        ),
        home: AuthScreen(),
        routes: {
          ProductOverviewScreen.routeName: (context) => ProductOverviewScreen(),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routename: (context) => CartScreen(),
          OrdersScreen.routeName: (context)=> OrdersScreen(),
          UserProductScreen.routeName:(context)=>UserProductScreen(),
          EditProductScreen.routeName:(context)=>EditProductScreen(),
        },
      ),
    );

  }
}
