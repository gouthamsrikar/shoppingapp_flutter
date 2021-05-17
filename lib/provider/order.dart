import 'package:flutter/foundation.dart';
import 'package:shoppingapp_flutter/provider/cart.dart';

class Orderitem {
  final String id;
  final double amount;
  final List<Cartitem> products;
  final DateTime dateTime;

  Orderitem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class OrderS with ChangeNotifier {
  List<Orderitem> _order = [];

  List<Orderitem> get orders {
    return [..._order];
  }

  void addOrder(List<Cartitem> cartProducts, double total) {
    _order.insert(
      0,
      Orderitem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
  
}
