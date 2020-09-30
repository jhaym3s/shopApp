import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider.value(
      value: ProductsProvider(),
      //you use the above method if you are not really interested in the context
      //apparently the .value is a better than the other when it comes to widgets that exceed the screen
      // like grid view or the list view
      //create: (BuildContext context) => ProductsProvider(),
      child: MaterialApp(
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
      ),
    );
  }
}
