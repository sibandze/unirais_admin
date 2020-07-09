import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import './../../../bloc/_bloc.dart';
import './../../../model/_model.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;

class ProductAddNewPage extends StatefulWidget {
  final ProductType productType;

  const ProductAddNewPage({Key key, @required this.productType})
      : super(key: key);

  @override
  _ProductAddNewPageState createState() => _ProductAddNewPageState();
}

class _ProductAddNewPageState extends State<ProductAddNewPage> {
  ProductType get _productType => widget.productType;
  TextEditingController _productNameController;
  TextEditingController _priceController;
  TextEditingController _packagingController;
  BlocProducts _blocProducts;
  ImagePicker _picker;
  PickedFile _image;
  Widget _productImage;

  @override
  void initState() {
    _productNameController = TextEditingController();
    _priceController = TextEditingController();
    _packagingController = TextEditingController();
    _picker = ImagePicker();
    _productImage = Container(); // TODO: add placeholder
    _blocProducts = BlocProvider.of<BlocProducts>(context);
    super.initState();
  }

  void _addProductImage() {
    final action = CupertinoActionSheet(
      message: Text(
        "Add product image",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Choose from gallery"),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            _image = await _picker.getImage(source: ImageSource.gallery);
            if (_image != null)
              setState(() {
                _productImage = Image.file(
                  File(_image.path),
                  fit: BoxFit.fitWidth,
                );
              });
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Take a picture"),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            _image = await ImagePicker().getImage(source: ImageSource.camera);
            if (_image != null)
              setState(() {
                _productImage = Image.file(
                  File(_image.path),
                  fit: BoxFit.fitWidth,
                );
              });
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  Future submitChanges() async {
    if (_productNameController.text.trim().isNotEmpty) {
      Product _product = Product(
          productTypeId: _productType.id,
          name: _productNameController.text.trim(),
          packaging: _packagingController.text.trim(),
          price: num.parse(_priceController.text.trim()));
      _blocProducts.add(BlocEventProductsCreate(product: _product));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new product'),
      ),
      body: BlocListener<BlocProducts, BlocStateProducts>(
        bloc: _blocProducts,
        listener: (BuildContext context, BlocStateProducts state) {
          if (state is BlocStateProductsCUDSuccess) {
            print('success');
            _blocProducts
                .add(BlocEventProductsFetch(productType: _productType));
            Navigator.of(context).pop();
          } else if (state is BlocStateProductsCUDFailure) {
            print('failure');
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _addProductImage();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            height: 200,
                            width: 200,
                            color: Colors.deepPurpleAccent,
                            child: _productImage,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      controller: _productNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        fillColor: Colors.white,
                        hintText: 'Product Name',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: PRESENTATION.PRIMARY_COLOR,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      controller: _packagingController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        fillColor: Colors.white,
                        hintText: 'Packaging',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: PRESENTATION.PRIMARY_COLOR,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        fillColor: Colors.white,
                        hintText: 'Price',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: PRESENTATION.PRIMARY_COLOR,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff1d2340),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: EdgeInsets.all(24.0),
              child: RaisedButton(
                onPressed: () async {
                  await submitChanges();
                },
                child: Text(
                  'Add product',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: PRESENTATION.BACKGROUND_COLOR,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(16),
                color: PRESENTATION.PRIMARY_COLOR,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
