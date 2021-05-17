import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp_flutter/provider/product_.dart';
import 'package:shoppingapp_flutter/provider/products.dart';
import 'package:shoppingapp_flutter/screens/edit_product_Screen.dart';
import 'package:shoppingapp_flutter/widgets/app_drawer.dart';
import 'package:shoppingapp_flutter/widgets/user_product_item.dart';

class Userproductscreen extends StatelessWidget {
  static const routename = '/userproducts';
  Future<void> _refreshproducts(BuildContext context) async {
    Provider.of<Produtsprovider>(context, listen: false).fetchandsetproducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Produtsprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('your products'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(Editproductscreen.routename);
              })
        ],
      ),
      drawer: Appdrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshproducts(context),
        child: Padding(
          child: ListView.builder(
            itemBuilder: (_, i) => Userproductitem(productsdata.items[i].id,
                productsdata.items[i].title, productsdata.items[i].imageurl),
            itemCount: productsdata.items.length,
          ),
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
