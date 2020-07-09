import 'dart:async';

import 'package:bloc/bloc.dart';

import './../const/_const.dart';
import './../model/_model.dart';
import './../repository/_repository.dart';
import './events/_events.dart';
import './states/_states.dart';

class BlocProducts extends Bloc<BlocEventProducts, BlocStateProducts> {
  final _productRepository = ProductRepository.productRepository;

  @override
  get initialState => BlocStateProductsUninitialized();

  @override
  Stream<BlocStateProducts> mapEventToState(BlocEventProducts event) async* {
    if (event is BlocEventProductsUpdate) {
      yield BlocStateProductsCUDProcessing();
      try {
        bool success = await _productRepository.updateProductType(
            product: event.product);  // TODO: add update product type method
        yield (success) ? BlocStateProductsCUDSuccess() : BlocStateProductsCUDFailure();
      } catch (e) {
        print(e);
        yield BlocStateProductsCUDFailure();
      }
    }
    else{
      if (event is BlocEventCategoriesCUD) {
        yield BlocStateProductsCUDProcessing();
        try {
          bool success = false;
          if (event is BlocEventProductsCreate) {
            success = await _productRepository.addProduct(
                product: event.product); // TODO: add add product type method
          } else if (event is BlocEventProductsDelete) {
            success = await _productRepository.deleteProduct(
                product: event.product); // TODO: add delete product type method
          }
          yield (success) ? BlocStateProductsCUDSuccess() : BlocStateProductsCUDFailure();
        } catch (e) {
          print(e);
          yield BlocStateProductsCUDFailure();
        }
      }
      else if(event is BlocEventProductsFetch){
        yield BlocStateProductsFetching();
        await Future.delayed(Duration(
          milliseconds: LOADING_DELAY_TIME,
        ));
        try {
          final List<Product> product = await _productRepository.getProducts(productType: event.productType);
          yield BlocStateProductsFetchingSuccess(products: product);
        } catch (e) {
          print(e);
          yield BlocStateProductsFetchingFailure();
        }
      }
    }
  }
}