import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp_flutter/provider/cart.dart';
import 'package:shoppingapp_flutter/provider/product_.dart';
import 'package:shoppingapp_flutter/widgets/app_drawer.dart';
import 'package:shoppingapp_flutter/widgets/badge.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingapp_flutter/widgets/productsgrid.dart';
import '../screens/cart_screen.dart';

enum Filteroptions {
  favourites,
  all,
}

class Productsoverviewscreen extends StatefulWidget {
  @override
  _ProductsoverviewscreenState createState() => _ProductsoverviewscreenState();
}

class _ProductsoverviewscreenState extends State<Productsoverviewscreen> {
  var _showonlyfav = false;
  var _intsta = true;
  var _isloading = false;

  @override
  void initState() {
    // Provider.of<Produtsprovider>(context).fetchandsetproducts();
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Produtsprovider>(context).fetchandsetproducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_intsta) {
      setState(() {
        _isloading = true;
      });
      Provider.of<Produtsprovider>(context).fetchandsetproducts().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _intsta = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productscontainer=Provider.of<Produtsprovider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Myschop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (Filteroptions selectedvalue) {
              setState(() {
                if (selectedvalue == Filteroptions.favourites) {
                  _showonlyfav = true;
                } else {
                  _showonlyfav = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('only favourites'),
                  value: Filteroptions.favourites),
              PopupMenuItem(child: Text('show all'), value: Filteroptions.all),
            ],
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemcount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(Cartscreen.routename);
              },
            ),
          ),
        ],
      ),
      drawer: Appdrawer(),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Productsgrid(_showonlyfav),
    );
  }
}
