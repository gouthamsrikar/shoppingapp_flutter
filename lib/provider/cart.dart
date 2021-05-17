

import 'package:flutter/foundation.dart';
import 'package:shoppingapp_flutter/widgets/cart_item.dart';

class Cartitem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  Cartitem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, Cartitem> _items = {};

  Map<String, Cartitem> get items {
    return {..._items};
  }

  int get itemcount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void additem(String productid, double price, String title) {
    if (_items.containsKey(productid)) {
      //change quantity
      _items.update(
          productid,
          (existingcartitem) => Cartitem(
              id: existingcartitem.id,
              title: existingcartitem.title,
              quantity: existingcartitem.quantity + 1,
              price: existingcartitem.price));
    } else {
      _items.putIfAbsent(
          productid,
          () => Cartitem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeitem(String productid) {
    _items.remove(productid);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removesingleitem(String productid) {
    if (!_items.containsKey(productid)) {
      return;
    }
    if (_items[productid].quantity > 1) {
      _items.update(
          productid,
          (existingcartitem) => Cartitem(
              id: existingcartitem.id,
              price: existingcartitem.price,
              quantity: existingcartitem.quantity - 1,
              title: existingcartitem.title));
    }
    else{
      _items.remove(productid);
    }
    notifyListeners();
  }
}
