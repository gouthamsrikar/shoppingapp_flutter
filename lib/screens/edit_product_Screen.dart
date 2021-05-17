import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp_flutter/provider/product_.dart';
import 'package:shoppingapp_flutter/provider/products.dart';

class Editproductscreen extends StatefulWidget {
  static const routename = '/editproductscreen';
  @override
  _EditproductscreenState createState() => _EditproductscreenState();
}

class _EditproductscreenState extends State<Editproductscreen> {
  final _pricefocusnode = FocusNode();
  final _descripfocusnode = FocusNode();
  final _imageurlcontroller = TextEditingController();
  final _imageurlfocusnode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedproduct =
      Product(id: null, title: '', price: 0, description: '', imageurl: '');

  var _isinit = true;
  var _isloading = false;
  var _initvalues = {
    'title': '',
    'description': '',
    'price': '',
    'imageurl': '',
  };
  @override
  void initState() {
    _imageurlfocusnode.addListener(_updateimageurl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      final productid = ModalRoute.of(context).settings.arguments as String;
      if (productid != null) {
        _editedproduct = Provider.of<Produtsprovider>(context, listen: false)
            .findbyid(productid);
        _initvalues = {
          'title': _editedproduct.title,
          'description': _editedproduct.description,
          'price': _editedproduct.price.toString(),
          'imageurl': '',
        };
        _imageurlcontroller.text = _editedproduct.imageurl;
      }
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  void _updateimageurl() {
    if (!_imageurlfocusnode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveform() async {
    final isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isloading = true;
    });
    if (_editedproduct.id != null) {
      await Provider.of<Produtsprovider>(context, listen: false)
          .updateproduct(_editedproduct.id, _editedproduct);
      setState(() {
        _isloading = false;
      });
    } else {
      try {
        await Provider.of<Produtsprovider>(context, listen: false)
            .addproduct(_editedproduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('error occured'),
            content: Text(
              error.toString(),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('okay'))
            ],
          ),
        );
      } finally {
        setState(() {
          _isloading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    _imageurlfocusnode.removeListener(_updateimageurl);
    _pricefocusnode.dispose();
    _descripfocusnode.dispose();
    _imageurlcontroller.dispose();
    _imageurlfocusnode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT PRODUCT'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveform)],
      ),
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(children: <Widget>[
                  TextFormField(
                    initialValue: _initvalues['title'],
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_pricefocusnode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'PLEASE PROVIDE A VALUE';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedproduct = Product(
                          title: value,
                          price: _editedproduct.price,
                          description: _editedproduct.description,
                          imageurl: _editedproduct.imageurl,
                          id: _editedproduct.id,
                          isfavourite: _editedproduct.isfavourite);
                    },
                  ),
                  TextFormField(
                    initialValue: _initvalues['price'],
                    decoration: InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _pricefocusnode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_descripfocusnode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'PLEASE enter price';
                      }
                      if (double.parse(value) == null) {
                        return 'please enter a valid number';
                      }
                      if (double.parse(value) <= 0) {
                        return 'please enter number greater than 0';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedproduct = Product(
                          title: _editedproduct.title,
                          price: double.parse(value),
                          description: _editedproduct.description,
                          imageurl: _editedproduct.imageurl,
                          id: _editedproduct.id,
                          isfavourite: _editedproduct.isfavourite);
                    },
                  ),
                  TextFormField(
                    initialValue: _initvalues['description'],
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descripfocusnode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'enter description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedproduct = Product(
                          title: _editedproduct.title,
                          price: _editedproduct.price,
                          description: value,
                          imageurl: _editedproduct.imageurl,
                          id: _editedproduct.id,
                          isfavourite: _editedproduct.isfavourite);
                    },
                  ),
                  Row(children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageurlcontroller.text.isEmpty
                          ? Text('Enter url')
                          : FittedBox(
                              child: Image.network(_imageurlcontroller.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'iamgeurl'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageurlcontroller,
                        focusNode: _imageurlfocusnode,
                        onFieldSubmitted: (_) {
                          _saveform();
                        },
                        onSaved: (value) {
                          _editedproduct = Product(
                              title: _editedproduct.title,
                              price: _editedproduct.price,
                              description: _editedproduct.description,
                              imageurl: value,
                              id: _editedproduct.id,
                              isfavourite: _editedproduct.isfavourite);
                        },
                      ),
                    ),
                  ])
                ]),
              ),
            ),
    );
  }
}
