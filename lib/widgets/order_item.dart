import 'package:flutter/material.dart';
import '../provider/order.dart' as ord;
import 'dart:math';

class Orderitem extends StatefulWidget {
  final ord.Orderitem order;
  Orderitem(this.order);

  @override
  _OrderitemState createState() => _OrderitemState();
}

class _OrderitemState extends State<Orderitem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 , 100),
              child: ListView(
                children: widget.order.products.map((prod) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text(prod.title),
                  Text('${prod.quantity}x\$${prod.price}')
                ])).toList(),
              ),
            )
        ],
      ),
    );
  }
}
