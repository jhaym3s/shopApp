import 'package:flutter/material.dart';
import '../widgets/productGrid.dart';


class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop App"),
      ),
      body: ProductGrid()
    );
  }
}
