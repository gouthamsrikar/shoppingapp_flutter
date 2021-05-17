import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp_flutter/provider/product_.dart';
import 'package:shoppingapp_flutter/screens/edit_product_Screen.dart';

class Userproductitem extends StatelessWidget {
  final String id;
  final String title;
  final String imageurl;

  Userproductitem(this.id, this.title, this.imageurl);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Container(
      width: 100,
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageurl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(Editproductscreen.routename, arguments: id);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<Produtsprovider>(context, listen: false)
                        .deteleproduct(id);
                  } catch (error) {
                    scaffold.showSnackBar(
                        SnackBar(content: Text('deleting failed')));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
