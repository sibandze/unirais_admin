import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../const/_const.dart' as CONSTANTS;

class Address extends Equatable {
  final int id;
  final String savedAs;
  final String roomNumber;
  final double long;
  final double lat;
  final String address;
  final int residence;
  final int university;

  Address({
    @required this.residence,
    @required this.university,
    this.id = -1,
    this.roomNumber,
    @required this.long,
    @required this.lat,
    @required this.savedAs,
    @required this.address,
  });

  factory Address.fromMap(Map map) =>
      Address(
        id: map[CONSTANTS.ROW_ID],
        long: map[CONSTANTS.ROW_LONG],
        lat: map[CONSTANTS.ROW_LAT],
        roomNumber: map[CONSTANTS.ROW_ROOM_NUMBER],
        savedAs: map[CONSTANTS.ROW_SAVED_AS],
        address: map[CONSTANTS.ROW_ADDRESS],
        university: map[CONSTANTS.ROW_UNIVERSITY],
        residence: map[CONSTANTS.ROW_RESIDENCE],
      );

  Map<String, dynamic> get toMap {
    return (id == -1) ? {
      CONSTANTS.ROW_SAVED_AS: savedAs,
      CONSTANTS.ROW_ADDRESS: address,
      CONSTANTS.ROW_LONG: long,
      CONSTANTS.ROW_LAT: lat,
      CONSTANTS.ROW_ROOM_NUMBER: roomNumber,
      CONSTANTS.ROW_UNIVERSITY: university,
      CONSTANTS.ROW_RESIDENCE: residence,
    } : {
      CONSTANTS.ROW_SAVED_AS: savedAs,
      CONSTANTS.ROW_ADDRESS: address,
      CONSTANTS.ROW_LONG: long,
      CONSTANTS.ROW_LAT: lat,
      CONSTANTS.ROW_ROOM_NUMBER: roomNumber,
      CONSTANTS.ROW_ID: id,
      CONSTANTS.ROW_UNIVERSITY: university,
      CONSTANTS.ROW_RESIDENCE: residence,
    };
  }

  @override
  List<Object> get props => [long, lat];
}
