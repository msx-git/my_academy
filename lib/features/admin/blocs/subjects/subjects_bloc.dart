import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/models.dart';
import '../../../../domain/repositories/admin_repositories/admin_subjects_repository.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  final AdminSubjectsRepository _subjectsRepository;

  SubjectsBloc({required AdminSubjectsRepository adminSubjectsRepository})
      : _subjectsRepository = adminSubjectsRepository,
        super(SubjectsInitialState()) {
    on<GetAllSubjectEvent>(_onGetAllSubject);
  }

  void _onGetAllSubject(GetAllSubjectEvent event, emit) async {
    emit(SubjectsLoadingState());
    try {
      final responseList = await _subjectsRepository.getAllSubjects();
      emit(SubjectsLoadedState(subjects: responseList));
    } catch (e) {
      emit(SubjectsErrorState(message: e.toString()));
    }
  }
}
