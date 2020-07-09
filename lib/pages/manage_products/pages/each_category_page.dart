import 'dart:io';

import './../../../bloc/_bloc.dart';
import './../../../model/_model.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;
import './../../../util/_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import './product_type_add_new_page.dart';

class EachCategoryPage extends StatefulWidget {
  final ProductCategory category;

  const EachCategoryPage({Key key, this.category}) : super(key: key);

  @override
  _EachCategoryPageState createState() => _EachCategoryPageState();
}

class _EachCategoryPageState extends State<EachCategoryPage> {
  ProductCategory get _category => widget.category;
  bool firstLoad = true;
  List<ProductType> _productTypes;
  BlocProductTypes _blocProductTypes;

  @override
  void initState() {
    _blocProductTypes = BlocProvider.of<BlocProductTypes>(context);
    _blocProductTypes.add(BlocEventProductTypesFetch(
      category: _category,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocProductTypes, BlocStateProductTypes>(
      bloc: _blocProductTypes,
      listener: (BuildContext context, BlocStateProductTypes state) {
        if (state is BlocStateProductTypesFetchingSuccess) {
          setState(() {
            if (state.productTypes.isNotEmpty) {
              firstLoad = false;
              _productTypes = state.productTypes;
            }
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_category.name),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: BlocBuilder<BlocProductTypes, BlocStateProductTypes>(
                bloc: _blocProductTypes,
                builder: (BuildContext context, BlocStateProductTypes state) {
                  if (state is BlocStateProductTypesUninitialized) {
                    return Center(
                      child: Text("Loading"),
                    );
                  } else if (state is BlocStateProductTypesFetching &&
                      firstLoad) {
                    return Center(
                      child: Text("Loading"),
                    );
                  } else if (state is BlocStateProductTypesFetchingFailure &&
                      firstLoad) {
                    return Center(
                      child: Text("Error"),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        ProductType _productType = _productTypes[index];
                        return _ProductTypeWidget(
                          productType: _productType,
                          category: _category,
                        );
                      },
                      itemCount: _productTypes.length,
                    );
                  }
                },
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {
            push(
                context,
                ProductTypeAddNewPage(
                  category: _category,
                ));
          },
          label: Text("Add  new product type"),
          icon: Icon(Icons.add_circle),
        ),
      ),
    );
  }
}

class _ProductTypeWidget extends StatefulWidget {
  final ProductType productType;
  final ProductCategory category;

  const _ProductTypeWidget(
      {Key key, @required this.productType, @required this.category})
      : super(key: key);

  @override
  _ProductTypeWidgetState createState() => _ProductTypeWidgetState();
}

class _ProductTypeWidgetState extends State<_ProductTypeWidget> {
  ProductType get _productType => widget.productType;

  ProductCategory get _category => widget.category;
  Widget _productTypeImage;
  ImagePicker _picker;
  Color _itemColor = Colors.deepPurpleAccent;
  TextEditingController _nameController;
  String _originalName;
  bool _editingName = false;
  bool _isUploadingImage = false;
  PickedFile _image;
  BlocProductTypes _blocProductTypes;

  @override
  void initState() {
    _blocProductTypes = BlocProvider.of<BlocProductTypes>(context);
    _picker = ImagePicker();
    _nameController = TextEditingController(text: _productType.name);
    _productTypeImage = Image.network(
      _productType.appUrlQualifiedImgUrl,
      fit: BoxFit.fitWidth,
      width: 80,
      height: 80,
    );
    super.initState();
  }

  void updateProductType() async {
    _originalName = _productType.name;
    _productType.name = _nameController.text;
    _blocProductTypes.add(BlocEventProductTypesCreate(
        productType: _productType)); // TODO: make patch work
  }

  void uploadPicture() async {
    if (_image != null)
      setState(() {
        _isUploadingImage = true;
      });

    // TODO: upload image to server
  }

  void _onUploadFail() async {
    // TODO: show snack bar telling user upload failed
    setState(() {
      _isUploadingImage = false;
    });
  }

  void onUploadComplete() async {
    // TODO: show snack bar telling user upload success
    setState(() {
      _isUploadingImage = false;
      _productTypeImage = Image.file(
        File(_image.path),
        fit: BoxFit.fitWidth,
        width: 80,
        height: 80,
      );
    });
  }

  void _editProductTypeImage() {
    final action = CupertinoActionSheet(
      message: Text(
        "Update product type cover image",
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocProductTypes, BlocStateProductTypes>(
      bloc: _blocProductTypes,
      listener: (BuildContext context, BlocStateProductTypes state) {
        if (state is BlocStateCategoriesCUDSuccess) {
          setState(() {
            _editingName = false;
          });
          _blocProductTypes
              .add(BlocEventProductTypesFetch(category: _category));
        } else if (state is BlocStateCategoriesCUDFailure) {
          _productType.name = _originalName;
          _nameController.text = _originalName;
          setState(() {
            _editingName = false;
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
                              child: _productTypeImage,
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
                                        _productType.name, //
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
                              (_editingName)
                                  ? IconButton(
                                      onPressed: () {
                                        updateProductType();
                                      },
                                      icon: Icon(Icons.send),
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '# of products :   ${_productType.productList.length}',
                            maxLines: 1,
                            style: TextStyle(
                              //fontSize: 13,
                              color: PRESENTATION.TEXT_LIGHT_COLOR,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Min price          :   ${_productType.minPrice.toString()}',
                            maxLines: 1,
                            style: TextStyle(
                              //fontSize: 13,
                              color: PRESENTATION.TEXT_LIGHT_COLOR,
                            ),
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
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: _itemColor,
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
}
