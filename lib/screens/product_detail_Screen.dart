import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp_flutter/provider/product_.dart';

class Productdetailscreen extends StatelessWidget {
  static const routename = '/product_Detail';

  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context).settings.arguments as String;
    final loadedproduct = Provider.of<Produtsprovider>(
      context,
      listen: false,
    ).findbyid(productid);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedproduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              child: Image.network(
                loadedproduct.imageurl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text('\$${loadedproduct.price}',style: TextStyle(fontSize: 20),),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Text(
                loadedproduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
