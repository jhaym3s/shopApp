import 'package:flutter/material.dart';
import 'package:shop/screens/productDetailScreen.dart';
import 'package:shop/screens/productOverviewScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Lato",
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
        //accentColorBrightness: Brightness.dark,
      ),
      routes: {
        "/": (context) => ProductOverviewScreen(),
        ProductDetailScreen.routeName: (context) => ProductDetailScreen()
      },
    );
  }
}
