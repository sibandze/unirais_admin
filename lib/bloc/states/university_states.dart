import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import './../../model/_model.dart';

class UniversityState extends Equatable {
  final _props;

  UniversityState({props}) : this._props = (props == null) ? [] : props;

  @override
  List<Object> get props => _props;
}

class InitialUniversityState extends UniversityState{}

class FetchingUniversities extends UniversityState {}

class FetchingUniversitiesSuccess extends UniversityState {
  final List<University> universities;

  FetchingUniversitiesSuccess({
    @required this.universities,
  }) : super(props: [universities]);
}

class FetchingUniversitiesFailure extends UniversityState {}
