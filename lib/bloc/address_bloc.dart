import 'package:bloc/bloc.dart';

import './../const/timers.dart';
import './../model/_model.dart';
import './../repository/address_repository.dart';
import './events/_events.dart';
import './states/_states.dart';

class BlocAddress extends Bloc<BlocEventAddress, BlocStateAddress> {
  final AddressRepository _addressRepository = AddressRepository();

  @override
  BlocStateAddress get initialState => BlocStateAddressInitial();

  @override
  Stream<BlocStateAddress> mapEventToState(BlocEventAddress event) async* {
    if (event is BlocEventAddressCUD) {
      yield BlocStateAddressCUDProcessing();
      try {
        if (event is BlocEventAddressCreate){
          await _addressRepository.addNewAddress(event.address);
        }
        else if (event is BlocEventAddressUpdate)
          await _addressRepository.updateAddress(event.address);
        else if (event is BlocEventAddressDelete)
          await _addressRepository.deleteAddress(event.address);
        else if (event is BlocEventAddressDeleteAll)
          await _addressRepository.deleteAllAddresses();
        yield BlocStateAddressCUDSuccess();
      } catch (e) {
        print(e);
        yield BlocStateAddressCUDFailure();
      }
      await Future.delayed(Duration(
        milliseconds: LOADING_DELAY_TIME,
      ));
    }
    yield BlocStateAddressFetching();
    try {
      final List<Address> addresses =
          await _addressRepository.getAllAddresses();
      yield BlocStateAddressFetchingSuccess(addresses);
    } catch (e) {
      print(e);
      BlocStateAddressFetchingFailure();
    }
  }
}
