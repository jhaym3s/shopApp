import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/screens/cartScreen.dart';
import './providers/cart.dart';
import './screens/productDetailScreen.dart';
import './screens/productOverviewScreen.dart';
import './providers/productProvider.dart';

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
        routes: {
          "/": (context) => ProductOverviewScreen(),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routename: (context) => CartScreen()
        },
      ),
    );

  }
}
