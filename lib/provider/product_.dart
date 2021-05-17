import 'package:flutter/material.dart';
import 'package:shoppingapp_flutter/models/http_exception.dart';
import 'package:shoppingapp_flutter/provider/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Produtsprovider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageurl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageurl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageurl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageurl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  // var _showfavourtiesonly=false;

  List<Product> get items {
    // if(_showfavourtiesonly){
    //   return _items.where((element) => element.isfavourite).toList();
    // }
    return [..._items];
  }

  List<Product> get favouriteitem {
    return _items.where((element) => element.isfavourite).toList();
  }

  // void showfavouritesonly(){
  //   _showfavourtiesonly=true;
  //   notifyListeners();
  // }
  // void showall(){
  //   _showfavourtiesonly=false;
  //   notifyListeners();
  // }
  Future<void> fetchandsetproducts() async {
    const urli =
        'https://shoppingappsample-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
    try {
      final response = await http.get(Uri.parse(urli));
      final extractedata = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedproducts = [];
      extractedata.forEach((prodid, prodata) {
        loadedproducts.add(Product(
          id: prodid,
          title: prodata['title'],
          description: prodata['description'],
          imageurl: prodata['imageurl'],
          isfavourite: prodata['isfavourite'],
          price: prodata['price'],
        ));
      });
      _items = loadedproducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Product findbyid(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addproduct(Product product) async {
    const urli =
        'https://shoppingappsample-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
    try {
      final response = await http.post(
        Uri.parse(urli),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageurl': product.imageurl,
          'price': product.price,
          'isfavourite': product.isfavourite,
        }),
      );
      final newproduct = Product(
          title: product.title,
          description: product.description,
          price: product.price,
          imageurl: product.imageurl,
          id: json.decode(response.body)['name']);
      _items.add(newproduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
    // .then((resonse) {

    // }).catchError((error){
    //   throw error;
    // });
  }

  Future<void> updateproduct(String id, Product newproduct) async {
    final prodindx = _items.indexWhere((prod) => prod.id == id);
    if (prodindx >= 0) {
      final urli =
          'https://shoppingappsample-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';
      await http.patch(Uri.parse(urli),
          body: json.encode({
            'title': newproduct.title,
            'description': newproduct.description,
            'imageurl': newproduct.imageurl,
            'price': newproduct.price,
          }));
      _items[prodindx] = newproduct;
      notifyListeners();
    } else {}
  }

  Future<void> deteleproduct(String id) async {
    final urli =
        'https://shoppingappsample-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';
    var existingproduct = _items.firstWhere((prod) => prod.id == id);
    final existprodindex = _items.indexWhere((prod) => prod.id == id);
    
    final response = await http.delete(Uri.parse(urli));
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(existprodindex, existingproduct);
      notifyListeners();
      throw Httpexception('could not delete product');
    }
    existingproduct = null;
  }
}
