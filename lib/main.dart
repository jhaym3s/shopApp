import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './screens/splashScreen.dart';
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
        ChangeNotifierProvider(create: (context) => Auth(),),
        ChangeNotifierProxyProvider<Auth,ProductsProvider>(create: null,
            update: (context, auth, previousProducts) =>  ProductsProvider(auth.token,auth.userId,previousProducts == null?[]:previousProducts.item),),
        ChangeNotifierProvider(create: (context) => Cart(),),
        ChangeNotifierProxyProvider<Auth,Orders>(create: null, update: (context, auth, previous) => Orders(auth.token,previous.orders == null?[]:previous.orders ),),
      ],
      child: Consumer<Auth>(
        builder: (BuildContext context, authData, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hey Buy',
            theme: ThemeData(
              fontFamily: "Lato",
              primaryColor: Colors.purple,
              accentColor: Colors.purpleAccent,
              //accentColorBrightness: Brightness.dark,
            ),
            home: authData.isAuth?ProductOverviewScreen():FutureBuilder(builder: (context, snapshot) => snapshot.connectionState== ConnectionState.waiting? SplashScreen():AuthScreen(),future: authData.tryAutoLogin(),),
            routes: {
              ProductOverviewScreen.routeName: (context) => ProductOverviewScreen(),
              OrdersScreen.routeName: (context)=> OrdersScreen(),
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
              CartScreen.routename: (context) => CartScreen(),
              UserProductScreen.routeName:(context)=>UserProductScreen(),
              EditProductScreen.routeName:(context)=>EditProductScreen(),
            },
          );
        },
      ),
    );

  }
}
