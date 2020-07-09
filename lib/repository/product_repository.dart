import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import './../const/_const.dart' as CONSTANTS;
import './../model/_model.dart';
import './../services/web_service/webservice.dart';

class ProductRepository {
  static final ProductRepository productRepository = ProductRepository();

  /// Category

  Future<List<ProductCategory>> getCategories(
          {String location = "all"}) async =>
      await WebService().get(
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

  Future<bool> addCategory({@required ProductCategory productCategory}) async {
    Map<String, dynamic> result = await WebService().post(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: productCategory.toMap(),
        url: CONSTANTS.API_URL + '/app/categories/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> updateCategory(
      {@required ProductCategory productCategory}) async {
    Map<String, dynamic> result = await WebService().patch(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: productCategory.toMap(),
        url: CONSTANTS.API_URL + '/app/categories/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> deleteCategory(
      {@required ProductCategory productCategory}) async {
    Map<String, dynamic> result = await WebService().delete(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        url: CONSTANTS.API_URL +
            '/app/categories/index.php/?product_category_id=${productCategory.id}',
      ),
    );
    return result['success'];
  }


  /// ProductType

  Future<List<ProductType>> getProductTypes(
      {@required ProductCategory category}) async =>
      await WebService().get(
        Resource(
          parse: (http.Response response) {
            var _result = jsonDecode(response.body);
            return (_result['product_types'] as List)
                .map((e) => ProductType.fromMap(e))
                .toList();
          },
          url: CONSTANTS.API_URL +
              '/app/product_type/?product_category_id=${category.id}',
        ),
      );

  Future<bool> addProductType({@required ProductType productType}) async {
    print('addProductType');
    print(productType.toMap().toString());

    Map<String, dynamic> result = await WebService().post(
      Resource(
        parse: (http.Response response) {
          print(response.body);
          return jsonDecode(response.body);
        },
        params: productType.toMap(),
        url: CONSTANTS.API_URL + '/app/product_type/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> updateProductType({@required ProductType productType}) async {
    Map<String, dynamic> result = await WebService().patch(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: productType.toMap(),
        url: CONSTANTS.API_URL + '/app/product_type/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> deleteProductType({@required ProductType productType}) async {
    Map<String, dynamic> result = await WebService().delete(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        url: CONSTANTS.API_URL +
            '/app/product_type/index.php/?product_type_id=${productType.id}',
      ),
    );
    return result['success'];
  }

  /// Product

  Future<List<Product>> getProducts(
      {@required ProductType productType}) async =>
      await WebService().get(
        Resource(
          parse: (http.Response response) {
            var _result = jsonDecode(response.body);
            return (_result['products'] as List)
                .map((e) => Product.fromMap(e))
                .toList();
          },
          url: CONSTANTS.API_URL +
              '/app/products/?product_type_id=${productType.id}',
        ),
      );

  Future<bool> addProduct({@required Product product}) async {
    Map<String, dynamic> result = await WebService().post(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: product.toMap(),
        url: CONSTANTS.API_URL + '/app/products/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> updateProduct({@required Product product}) async {
    Map<String, dynamic> result = await WebService().patch(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: product.toMap(),
        url: CONSTANTS.API_URL + '/app/products/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> deleteProduct({@required Product product}) async {
    Map<String, dynamic> result = await WebService().delete(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        url: CONSTANTS.API_URL +
            '/app/products/index.php/?product_id=${product.id}',
      ),
    );
    return result['success'];
  }
}