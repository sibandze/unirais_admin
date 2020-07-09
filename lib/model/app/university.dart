import 'package:equatable/equatable.dart';
import './../../const/_const.dart' as CONSTANTS;

import './residence.dart';

class University extends Equatable {
  final String name;
  final String alias;
  final int id;
  final List<Residence> residences;

  University({this.name, this.alias, this.id, this.residences});

  factory University.fromMap(Map map) {
    return University(
      name: map[CONSTANTS.ROW_NAME],
      alias: map[CONSTANTS.ROW_ALIAS],
      id: map[CONSTANTS.ROW_ID],
      residences: (map['residences'] as List)
          .map((res) => Residence.fromMap(res))
          .toList(),
    );
  }

  @override
  List<Object> get props => [id];
}
