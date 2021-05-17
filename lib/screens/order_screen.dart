import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp_flutter/provider/order.dart';
import 'package:shoppingapp_flutter/widgets/app_drawer.dart';
import '../widgets/order_item.dart' as orditm;

class Orderscreen extends StatelessWidget {
  static const routename='/orders';
  @override
  Widget build(BuildContext context) {
    final ordersdata=Provider.of<OrderS>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('your orders'),
      ),
      drawer: Appdrawer(),
      body: ListView.builder(itemBuilder: (ctx,i)=>orditm.Orderitem(ordersdata.orders[i]),itemCount: ordersdata.orders.length,),
    );
  }
}
