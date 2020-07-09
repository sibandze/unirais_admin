import './../database/_database.dart';
import './../model/_model.dart';

class AddressRepository {
  static final AddressRepository addressRepository = AddressRepository();
  final AddressDao _addressDao = AddressDao();

  Future addNewAddress(Address address) => _addressDao.addNewAddress(address);

  Future deleteAddress(Address address) => _addressDao.deleteAddress(address);

  Future deleteAllAddresses() => _addressDao.deleteAllAddresses();

  Future getAllAddresses() => _addressDao.getAddresses();

  Future updateAddress(Address address) => _addressDao.updateAddress(address);
}
