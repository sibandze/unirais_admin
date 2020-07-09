import 'dart:io';

import 'package:UniRaisAdmin/bloc/_bloc.dart';
import 'package:UniRaisAdmin/bloc/categories_bloc.dart';
import 'package:UniRaisAdmin/model/_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import './../../../presentation/_presentation.dart' as PRESENTATION;
import 'package:flutter/material.dart';

class ProductTypeAddNewPage extends StatefulWidget {
  @override
  _ProductTypeAddNewPageState createState() => _ProductTypeAddNewPageState();
}

class _ProductTypeAddNewPageState extends State<ProductTypeAddNewPage> {
  TextEditingController _productTypeNameController;
  BlocCategories _categoriesBloc;
  ImagePicker _picker;
  PickedFile _image;
  Widget _productTypeImage;

  @override
  void initState() {
    _productTypeNameController = TextEditingController();
    _picker = ImagePicker();
    _productTypeImage = Container(); // TODO: add place older
    _categoriesBloc = BlocProvider.of<BlocCategories>(context);
    super.initState();
  }

  void _addProductTypeImage() {
    final action = CupertinoActionSheet(
      message: Text(
        "Add product type cover image",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Choose from gallery"),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            _image = await ImagePicker().getImage(source: ImageSource.gallery);
            if(_image!=null)
              setState(() {
                _productTypeImage = Image.file(
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
            if(_image!=null)
              setState(() {
                _productTypeImage = Image.file(
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
    if (
    _productTypeNameController.text.trim().isNotEmpty
    ) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new product type'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _addProductTypeImage();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 200,
                          width: 200,
                          color: Colors.deepPurpleAccent,
                          child: _productTypeImage,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextFormField(
                    controller: _productTypeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      fillColor: Colors.white,
                      hintText: 'Product type Name',
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
                'Add product type',
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
    );
  }
}
