import 'dart:async';

import 'package:bloc/bloc.dart';

import './../const/_const.dart';
import './../model/_model.dart';
import './../repository/_repository.dart';
import './events/_events.dart';
import './states/_states.dart';

class BlocProductTypes
    extends Bloc<BlocEventProductTypes, BlocStateProductTypes> {
  final _productRepository = ProductRepository.productRepository;

  @override
  get initialState => BlocStateProductTypesUninitialized();

  @override
  Stream<BlocStateProductTypes> mapEventToState(
      BlocEventProductTypes event) async* {
    if (event is BlocEventProductTypesUpdate) {
      yield BlocStateProductTypesCUDProcessing();
      try {
        bool success = await _productRepository.updateProductType(
            productType: event.productType);
        yield (success)
            ? BlocStateProductTypesCUDSuccess()
            : BlocStateProductTypesCUDFailure();
      } catch (e) {
        print(e);
        yield BlocStateProductTypesCUDFailure();
      }
    } else {
      if (event is BlocEventProductTypesCUD) {
        yield BlocStateProductTypesCUDProcessing();
        try {
          bool success = false;
          if (event is BlocEventProductTypesCreate) {
            print('Before BlocEventProductTypesCreate');
            success = await _productRepository.addProductType(
                productType: event.productType);
            print('AFTER BlocEventProductTypesCreate');
          } else if (event is BlocEventProductTypesDelete) {
            success = await _productRepository.deleteProductType(
                productType: event.productType);
          }
          yield (success)
              ? BlocStateProductTypesCUDSuccess()
              : BlocStateProductTypesCUDFailure();
        } catch (e) {
          print(e);
          yield BlocStateProductTypesCUDFailure();
        }
      } else if (event is BlocEventProductTypesFetch) {
        yield BlocStateProductTypesFetching();
        await Future.delayed(Duration(
          milliseconds: LOADING_DELAY_TIME,
        ));
        try {
          final List<ProductType> productTypes = await _productRepository
              .getProductTypes(category: event.category);
          yield BlocStateProductTypesFetchingSuccess(
              productTypes: productTypes);
        } catch (e) {
          print(e);
          yield BlocStateProductTypesFetchingFailure();
        }
      }
    }
  }
}
