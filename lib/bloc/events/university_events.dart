import 'package:equatable/equatable.dart';

class UniversityEvent extends Equatable {
  final _props;

  UniversityEvent({props}) : this._props = (props == null) ? [] : props;

  @override
  List<Object> get props => _props;
}

class FetchUniversities extends UniversityEvent {}
