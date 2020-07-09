import 'dart:async';

import 'package:bloc/bloc.dart';

import './../const/_const.dart';
import './../repository/_repository.dart';
import './events/_events.dart';
import './states/_states.dart';

class BlocCategories extends Bloc<BlocEventCategories, BlocStateCategories> {
  final _productRepository = ProductRepository.productRepository;

  @override
  get initialState => BlocStateCategoriesUninitialized();

  @override
  Stream<BlocStateCategories> mapEventToState(BlocEventCategories event) async* {
    if (event is BlocEventCategoriesUpdate) {
      yield BlocStateCategoriesCUDProcessing();
      try {
        bool success = await _productRepository.updateCategory(
              productCategory: event.category);
        yield (success) ? BlocStateCategoriesCUDSuccess() : BlocStateCategoriesCUDFailure();
      } catch (e) {
        print(e);
        yield BlocStateCategoriesCUDFailure();
      }
    }
    else{
      if (event is BlocEventCategoriesCUD) {
        yield BlocStateCategoriesCUDProcessing();
        try {
          bool success = false;
          if (event is BlocEventCategoriesCreate) {
            success = await _productRepository.addCategory(
                productCategory: event.category);
          } else if (event is BlocEventCategoriesDelete) {
            success = await _productRepository.deleteCategory(
                productCategory: event.category);
          }
          yield (success) ? BlocStateCategoriesCUDSuccess() : BlocStateCategoriesCUDFailure();
        } catch (e) {
          print(e);
          yield BlocStateCategoriesCUDFailure();
        }
      }
      yield BlocStateCategoriesFetching();
      await Future.delayed(Duration(
        milliseconds: LOADING_DELAY_TIME,
      ));
      try {
        final categories = await _productRepository.getCategories();
        yield BlocStateCategoriesFetchingSuccess(categories: categories);
      } catch (e) {
        print(e);
        yield BlocStateCategoriesFetchingFailure();
      }
    }
  }
}