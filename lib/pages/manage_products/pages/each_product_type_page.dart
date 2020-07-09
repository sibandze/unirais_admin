import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import './../../../bloc/_bloc.dart';
import './../../../model/_model.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;
import './../../../util/_util.dart';
import './product_add_new_page.dart';

class EachProductTypePage extends StatefulWidget {
  final ProductType productType;

  const EachProductTypePage({Key key, @required this.productType})
      : super(key: key);

  @override
  _EachProductTypePageState createState() => _EachProductTypePageState();
}

class _EachProductTypePageState extends State<EachProductTypePage> {
  ProductType get _productType => widget.productType;
  BlocProducts _blocProducts;
  bool firstLoad = true;
  List<Product> _products;

  @override
  void initState() {
    _blocProducts = BlocProvider.of<BlocProducts>(context);
    _blocProducts.add(BlocEventProductsFetch(
      productType: _productType,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_productType.name),
      ),
      body: BlocListener<BlocProducts, BlocStateProducts>(
        bloc: _blocProducts,
        listener: (BuildContext context, BlocStateProducts state) {
          if (state is BlocStateProductsFetchingSuccess) {
            setState(() {
              if (state.products.isNotEmpty) {
                firstLoad = false;
                _products = state.products;
              }
            });
          }
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: BlocBuilder<BlocProducts, BlocStateProducts>(
                bloc: _blocProducts,
                builder: (BuildContext context, BlocStateProducts state) {
                  if (state is BlocStateProductsUninitialized) {
                    return Center(
                      child: Text("Loading"),
                    );
                  } else if (state is BlocStateProductsFetching && firstLoad) {
                    return Center(
                      child: Text("Loading"),
                    );
                  } else if (state is BlocStateProductsFetchingFailure &&
                      firstLoad) {
                    return Center(
                      child: Text("Error"),
                    );
                  } else if (_products == null || _products.length == 0) {
                    return Center(
                      child: Text("Empty"),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        Product _product = _products[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: (index == _products.length - 1) ? 72 : 0),
                          child: _ProductWidget(
                            productType: _productType,
                            product: _product,
                          ),
                        );
                      },
                      itemCount: _products.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigoAccent,
        onPressed: () {
          push(
              context,
              ProductAddNewPage(
                productType: _productType,
              ));
        },
        label: Text("Add  new product"),
        icon: Icon(Icons.add_circle),
      ),
    );
  }
}

class _ProductWidget extends StatefulWidget {
  final ProductType productType;
  final Product product;

  const _ProductWidget(
      {Key key, @required this.productType, @required this.product})
      : super(key: key);

  @override
  __ProductWidgetState createState() => __ProductWidgetState();
}

class __ProductWidgetState extends State<_ProductWidget> {
  Widget _productImage;
  ImagePicker _picker;
  Color _itemColor = Colors.indigoAccent;
  TextEditingController _nameController;
  TextEditingController _packagingController;
  TextEditingController _priceController;
  String _originalName;
  String _originalPackaging;
  Money _originalPrice;
  bool _editingName = false;
  bool _editingPackaging = false;
  bool _editingPrice = false;
  bool _isUploadingImage = false;
  PickedFile _image;
  BlocProducts _blocProducts;

  bool _isUpdating = false;

  ProductType get _productType => widget.productType;

  Product get _product => widget.product;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocProducts, BlocStateProducts>(
      bloc: _blocProducts,
      listener: (BuildContext context, BlocStateProducts state) {
        if (state is BlocStateProductsCUDSuccess) {
          setState(() {
            _isUpdating = false;
            _editingName = false;
            _editingPackaging = false;
            _editingPrice = false;
          });
          _blocProducts.add(BlocEventProductsFetch(productType: _productType));
        } else if (state is BlocStateProductsCUDFailure) {
          setState(() {
            _product.name = _originalName;
            _nameController.text = _originalName;
            _product.packaging = _originalPackaging;
            _packagingController.text = _originalPackaging;
            _product.price = Money(_originalPrice.amount);
            _priceController.text = _originalPrice.amount.toString();
            _isUpdating = false;
            _editingName = false;
            _editingPackaging = false;
            _editingPrice = false;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 24,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: kElevationToShadow[8],
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(24),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(24),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: PRESENTATION.BACKGROUND_COLOR,
                border: Border(
                  left: BorderSide(
                    width: 24.0,
                    color: _itemColor,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 12,
                  ),
                  (_isUploadingImage)
                      ? CircularProgressIndicator()
                      : InkWell(
                          onDoubleTap: () {
                            _editProductTypeImage();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              color: Colors.white,
                              child: _productImage,
                            ),
                          ),
                        ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              (!_editingName)
                                  ? InkWell(
                                      onDoubleTap: () async {
                                        setState(() {
                                          _editingName = true;
                                        });
                                      },
                                      child: Text(
                                        _product.name, //
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                      ),
                                    )
                                  : Expanded(
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 15),
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          contentPadding: new EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                          ),
                                          hintText: 'Name',
                                          hintStyle: TextStyle(
                                            color:
                                                PRESENTATION.TEXT_LIGHT_COLOR,
                                            fontSize: 13,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: PRESENTATION.PRIMARY_COLOR,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              if (_editingName && _isUpdating)
                                CircularProgressIndicator()
                              else if (_editingName)
                                IconButton(
                                  onPressed: () {
                                    updateProduct();
                                  },
                                  icon: Icon(Icons.send),
                                )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              (!_editingPackaging)
                                  ? InkWell(
                                      onDoubleTap: () async {
                                        setState(() {
                                          _editingPackaging = true;
                                        });
                                      },
                                      child: Text(
                                        'Packaging :   ${_product.packaging}',
                                        maxLines: 1,
                                        style: TextStyle(
                                          //fontSize: 13,
                                          color: PRESENTATION.TEXT_LIGHT_COLOR,
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 13),
                                        controller: _packagingController,
                                        decoration: InputDecoration(
                                          contentPadding: new EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                          ),
                                          hintText: 'Packaging',
                                          hintStyle: TextStyle(
                                            color:
                                                PRESENTATION.TEXT_LIGHT_COLOR,
                                            fontSize: 12,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: PRESENTATION.PRIMARY_COLOR,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              if (_editingPackaging && _isUpdating)
                                CircularProgressIndicator()
                              else if (_editingPackaging)
                                IconButton(
                                  onPressed: () {
                                    updateProduct();
                                  },
                                  icon: Icon(Icons.send),
                                )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              (!_editingPrice)
                                  ? InkWell(
                                      onDoubleTap: () async {
                                        setState(() {
                                          _editingPrice = true;
                                        });
                                      },
                                      child: Text(
                                        'price          :   ${_product.price.toString()}',
                                        maxLines: 1,
                                        style: TextStyle(
                                          //fontSize: 13,
                                          color: PRESENTATION.TEXT_LIGHT_COLOR,
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 13),
                                        controller: _priceController,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        decoration: InputDecoration(
                                          contentPadding: new EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                          ),
                                          hintText: 'Price',
                                          hintStyle: TextStyle(
                                            color:
                                                PRESENTATION.TEXT_LIGHT_COLOR,
                                            fontSize: 12,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: PRESENTATION.PRIMARY_COLOR,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              if (_editingPrice && _isUpdating)
                                CircularProgressIndicator()
                              else if (_editingPrice)
                                IconButton(
                                  onPressed: () {
                                    updateProduct();
                                  },
                                  icon: Icon(Icons.send),
                                )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _blocProducts = BlocProvider.of<BlocProducts>(context);
    _picker = ImagePicker();
    _nameController = TextEditingController(text: _product.name);
    _packagingController = TextEditingController(text: _product.packaging);
    _priceController =
        TextEditingController(text: _product.price.amount.toString());
    _productImage = Image.network(
      _product.appUrlQualifiedImgUrl,
      fit: BoxFit.fitWidth,
      width: 80,
      height: 80,
    );
    super.initState();
  }

  void onUploadComplete() async {
    // TODO: show snack bar telling user upload success
    setState(() {
      _isUploadingImage = false;
      _productImage = Image.file(
        File(_image.path),
        fit: BoxFit.fitWidth,
        width: 80,
        height: 80,
      );
    });
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = response.file;
      });
    }
  }

  void updateProduct() async {
    _originalName = _product.name;
    _product.name = _nameController.text;
    _originalPackaging = _product.packaging;
    _product.packaging = _packagingController.text;
    _originalPrice = Money(_product.price.amount);
    _product.price = Money(num.parse(_priceController.text));
    _isUpdating = true;
    _blocProducts.add(
        BlocEventProductsCreate(product: _product)); // TODO: make patch work
  }

  void uploadPicture() async {
    if (_image != null)
      setState(() {
        _isUploadingImage = true;
      });

    // TODO: upload image to server
  }

  void _editProductTypeImage() {
    final action = CupertinoActionSheet(
      message: Text(
        "Update product image",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Choose from gallery"),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            _image = await ImagePicker().getImage(source: ImageSource.gallery);
            uploadPicture();
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Take a picture"),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            _image = await ImagePicker().getImage(source: ImageSource.camera);
            uploadPicture();
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

  void _onUploadFail() async {
    // TODO: show snack bar telling user upload failed
    setState(() {
      _isUploadingImage = false;
    });
  }
}
