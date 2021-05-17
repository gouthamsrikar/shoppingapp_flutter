import 'package:flutter/material.dart';
import 'package:shoppingapp_flutter/screens/user_products.dart';
import '../screens/order_screen.dart';

class Appdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('hello ffrined'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(Orderscreen.routename),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('manage products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(Userproductscreen.routename),
          ),
        ],
      ),
    );
  }
}
