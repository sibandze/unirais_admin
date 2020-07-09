import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../bloc/_bloc.dart';
import './../../model/_model.dart';
import './../../pages/manage_products/pages/_pages.dart';
import './../../pages/manage_products/pages/each_category_page.dart';
import './../../presentation/_presentation.dart' as PRESENTATION;
import './../../util/_util.dart';

const _PAGE_TITLE = "Manage Products";

class ManageProductsPage extends StatefulWidget {
  @override
  _ManageProductsPageState createState() => _ManageProductsPageState();
}

class __CategoryWidgetState extends State<_CategoryWidget> {
  Color _itemColor = Colors.redAccent;
  TextEditingController _nameController;
  String _originalName;

  BlocCategories _categoryBloc;

  ProductCategory get _category => widget.category;
  bool _editingName = false;

  @override
  void initState() {
    _categoryBloc = BlocProvider.of<BlocCategories>(context);
    _nameController = TextEditingController(text: _category.name);
    super.initState();
  }

  void updateCategory() async {
    _originalName = _category.name;
    _category.name = _nameController.text;
    _categoryBloc.add(BlocEventCategoriesCreate(category: _category)); // TODO: make patch work
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocCategories, BlocStateCategories>(
      bloc: _categoryBloc,
      listener: (BuildContext context, BlocStateCategories state) {
        if (state is BlocStateCategoriesCUDSuccess) {
          setState(() {
            _editingName = false;
          });
          _categoryBloc.add(BlocEventCategoriesFetch());
        } else if (state is BlocStateCategoriesCUDFailure) {
          _category.name = _originalName;
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
                              Icon(
                                Icons.bookmark,
                                color: _itemColor,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              (!_editingName)
                                  ? InkWell(
                                      onDoubleTap: () async {
                                        setState(() {
                                          _editingName = true;
                                        });
                                      },
                                      child: Text(
                                        _category.name, //
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
                                        updateCategory();
                                      },
                                      icon: Icon(Icons.check_circle_outline),
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '# of product types :   ${_category.productTypeList.length}',
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
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: _itemColor,
                    ),
                    onPressed: () {
                      push(context, EachCategoryPage(category: _category));
                    },
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
}

class _CategoryWidget extends StatefulWidget {
  final ProductCategory category;

  const _CategoryWidget({Key key, @required this.category}) : super(key: key);

  @override
  __CategoryWidgetState createState() => __CategoryWidgetState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  BlocCategories _categoriesBloc;
  List<ProductCategory> _productCategories;
  bool firstLoad = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocCategories, BlocStateCategories>(
      bloc: _categoriesBloc,
      listener: (BuildContext context, BlocStateCategories state) async {
        if (state is BlocStateCategoriesFetchingSuccess) {
          setState(() {
            if (state.categories.isNotEmpty) {
              firstLoad = false;
              _productCategories = state.categories;
            }
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_PAGE_TITLE),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: BlocBuilder<BlocCategories, BlocStateCategories>(
                bloc: _categoriesBloc,
                builder: (BuildContext context, BlocStateCategories state) {
                  if (state is BlocStateCategoriesUninitialized) {
                    return Center(
                      child: Text("Loading"),
                    );
                  }
                  else if (state is BlocStateCategoriesFetching && firstLoad) {
                    return Center(
                      child: Text("Loading"),
                    );
                  }
                  else if (state is BlocStateCategoriesFetchingFailure &&
                      firstLoad) {
                    return Center(
                      child: Text("Error"),
                    );
                  }
                  else if (_productCategories != null) {
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        ProductCategory category = _productCategories[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: (index == _productCategories.length - 1)
                                  ? 72
                                  : 0),
                          child: _CategoryWidget(
                            category: category,
                          ),
                        );
                      },
                      itemCount: _productCategories.length,
                    );
                  }
                  else {
                    return Center(
                      child: Text("Empty"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          onPressed: () {
            push(context, CategoryAddNewPage());
          },
          label: Text("Add  new category"),
          icon: Icon(Icons.add_circle),
        ),
      ),
    );
  }

  @override
  void initState() {
    _categoriesBloc = BlocProvider.of<BlocCategories>(context);
    _categoriesBloc.add(BlocEventCategoriesFetch());
    super.initState();
  }
}
