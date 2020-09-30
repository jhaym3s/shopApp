import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productProvider.dart';
import '../widgets/productItem.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final products = productData.item;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        //create: (BuildContext context) => products[index],
        child: ProductItem(
            // products[index].imageUrl,
            // products[index].id,
            // products[index].title
    ),
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(8),
    );
  }
}
