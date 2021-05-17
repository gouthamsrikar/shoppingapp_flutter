import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp_flutter/provider/cart.dart';
import 'package:shoppingapp_flutter/provider/products.dart';
import 'package:shoppingapp_flutter/screens/product_detail_Screen.dart';

class Productitem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageurl;
  // Productitem(this.id, this.title, this.imageurl);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(Productdetailscreen.routename,
                arguments: product.id);
          },
          child: Image.network(
            product.imageurl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isfavourite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.togglefavouritestatus();
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.additem(product.id, product.price, product.title); 
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('added item to the cart'),
                  duration: Duration(seconds: 1),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removesingleitem(product.id);
                      }),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
