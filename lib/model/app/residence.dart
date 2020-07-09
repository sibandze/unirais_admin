import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Residence extends Equatable {
  final String name;
  final int id;
  final double long;
  final double lat;
  final int zipCode;
  final int universityId;

  Residence({
    @required this.name,
    @required this.id,
    @required this.long,
    @required this.lat,
    @required this.zipCode,
    @required this.universityId,
  });

  @override
  List<Object> get props => [id, long, lat];

  factory Residence.fromMap(Map res) {
    return Residence(
      zipCode: res['zip_code'],
      long: (res['lon'] is int)?res['lon'].toDouble():res['lon'],
      lat: (res['lat'] is int)?res['lat'].toDouble():res['lat'],
      id: res['id'],
      universityId: res['university_id'],
      name: res['name'],
    );
  }
}
