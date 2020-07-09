import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import './../const/_const.dart' as CONSTANTS;
import './../model/_model.dart';
import './../services/web_service/webservice.dart';

class ProductRepository {
  static final ProductRepository productRepository = ProductRepository();

  // ignore: non_constant_identifier_names
  List<ProductCategory> _product_category_list;

  // ignore: non_constant_identifier_names
  List<Product> _product_list;

  String _location;

  ProductRepository()
      : _product_category_list = [],
        _product_list = [];

  Future<bool> addCategory({@required ProductCategory productCategory}) async {
    Map<String, dynamic> orderResult = await WebService().post(
      Resource(
        parse: (http.Response response) {
          print(response.body);
          return jsonDecode(response.body);
        },
        params: productCategory.toMap(),
        url: CONSTANTS.API_URL + '/app/categories/index.php',
      ),
    );
    return orderResult['success'];
  }

  Future<bool> updateCategory(
      {@required ProductCategory productCategory}) async {
    Map<String, dynamic> orderResult = await WebService().patch(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: productCategory.toMap(),
        url: CONSTANTS.API_URL + '/app/categories/index.php',
      ),
    );
    return orderResult['success'];
  }

  Future<bool> deleteCategory(
      {@required ProductCategory productCategory}) async {
    Map<String, dynamic> orderResult = await WebService().delete(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        url: CONSTANTS.API_URL +
            '/app/categories/index.php/?product_category_id=${productCategory.id}',
      ),
    );
    return orderResult['success'];
  }

  Future<List<Product>> getProducts({@required ProductType productType}) async {
    if (productType != null) {
      _product_list = await WebService().get(
        Resource(
          parse: (http.Response response) {
            var _result = jsonDecode(response.body);
            return (_result['products'] as List)
                .map((e) => Product.fromMap(e))
                .toList();
          },
          url: CONSTANTS.API_URL + '/app/products/?ptid=${productType.id}',
        ),
      );
    }
    return _product_list;
  }

  Future<List<ProductCategory>> getCategories({String location = "all"}) async {
    _product_category_list = await WebService().get(
      Resource(
        parse: (http.Response response) {
          var _result = jsonDecode(response.body);
          return (_result['categories'] as List)
              .map((e) => ProductCategory.fromMap(e))
              .toList();
        },
        url: CONSTANTS.API_URL + '/app/categories/?' + 'location=$location',
      ),
    );
    return _product_category_list;
  }

  Future<bool> updateProductType({Product product}) {}

  addProduct({Product product}) {}

  deleteProduct({Product product}) {}
}
