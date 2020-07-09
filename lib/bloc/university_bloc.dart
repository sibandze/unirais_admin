import 'package:bloc/bloc.dart';

import './../model/_model.dart';
import './../repository/_repository.dart';
import 'events/university_events.dart';
import 'states/university_states.dart';

class BlocUniversity extends Bloc<UniversityEvent, UniversityState> {
  final _universityRepository = UniversityRepository.universityRepository;

  @override
  UniversityState get initialState => InitialUniversityState();

  @override
  Stream<UniversityState> mapEventToState(UniversityEvent event) async* {
    if (event is FetchUniversities) {
      yield FetchingUniversities();
      try {
        List<University> universities = await _universityRepository.getUniversities();
        yield FetchingUniversitiesSuccess(universities: universities);
      } catch (e) {
        print(e);
        yield FetchingUniversitiesFailure();
      }
    }
  }
}
