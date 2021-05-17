import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp_flutter/widgets/product_item.dart';
import '../provider/product_.dart';

class Productsgrid extends StatelessWidget {
  final bool showfavs;
  Productsgrid(this.showfavs);
  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Produtsprovider>(context);
    final products = showfavs? productsdata.favouriteitem : productsdata.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (c)=>products[i],
        value: products[i],
        child: Productitem(
            // products[i].id,
            // products[i].title,
            // products[i].imageurl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
