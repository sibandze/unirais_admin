import 'package:UniRaisAdmin/bloc/_bloc.dart';
import 'package:UniRaisAdmin/bloc/categories_bloc.dart';
import 'package:UniRaisAdmin/model/_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../../presentation/_presentation.dart' as PRESENTATION;
import 'package:flutter/material.dart';

class CategoryAddNewPage extends StatefulWidget {


  @override
  _CategoryAddNewPageState createState() => _CategoryAddNewPageState();
}

class _CategoryAddNewPageState extends State<CategoryAddNewPage> {
  TextEditingController _productNameController = TextEditingController();
  BlocCategories _categoriesBloc;

  @override
  void initState() {
    _categoriesBloc = BlocProvider.of<BlocCategories>(context);
    super.initState();
  }

  Future submitChanges() async {
    if (
      _productNameController.text.trim().isNotEmpty
    ) {
      ProductCategory _category
        = ProductCategory(name: _productNameController.text);
      _categoriesBloc.add(BlocEventCategoriesCreate(category: _category));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new category'),
      ),
      body: BlocListener<BlocCategories, BlocStateCategories>(
        bloc: _categoriesBloc,
        listener: (BuildContext context, BlocStateCategories state) {
          if(state is BlocStateCategoriesCUDSuccess){
            Navigator.of(context).pop();
          }
          else if(state is BlocStateCategoriesCUDFailure){

          }
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextFormField(
                      controller: _productNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        fillColor: Colors.white,
                        hintText: 'Category Name',
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
                  'Add category',
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
