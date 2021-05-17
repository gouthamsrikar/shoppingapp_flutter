import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp_flutter/provider/cart.dart';
import 'package:shoppingapp_flutter/provider/order.dart';
import '../widgets/cart_item.dart' as ci;

class Cartscreen extends StatelessWidget {
  static const routename = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('YOUR CART'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 30,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: TextStyle(
                            color:
                                Theme.of(context).primaryTextTheme.title.color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                        onPressed: () {
                          Provider.of<OrderS>(context, listen: false).addOrder(
                              cart.items.values.toList(), cart.totalAmount);
                          cart.clear();
                        },
                        child: Text('order now'))
                  ]),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => ci.Cartitem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title),
            itemCount: cart.items.length,
          ))
        ],
      ),
    );
  }
}
