import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp_flutter/provider/order.dart';
import 'package:shoppingapp_flutter/screens/cart_screen.dart';
import 'package:shoppingapp_flutter/screens/edit_product_Screen.dart';

import 'package:shoppingapp_flutter/screens/product_detail_Screen.dart';
import 'package:shoppingapp_flutter/screens/products_overview_screen.dart';
import 'package:shoppingapp_flutter/screens/user_products.dart';
import './provider/product_.dart';
import './provider/cart.dart';
import './screens/order_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Produtsprovider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderS(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        home: Productsoverviewscreen(),
        routes: {
          Productdetailscreen.routename: (ctx) => Productdetailscreen(),
          Cartscreen.routename: (ctx) => Cartscreen(),
          Orderscreen.routename: (ctx) => Orderscreen(),
          Userproductscreen.routename: (ctx) => Userproductscreen(),
          Editproductscreen.routename: (ctx) => Editproductscreen(),
        },
      ),
    );
  }
}
