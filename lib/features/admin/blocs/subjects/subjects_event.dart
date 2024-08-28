part of 'subjects_bloc.dart';

sealed class SubjectsEvent extends Equatable {
  const SubjectsEvent();
}

final class GetAllSubjectEvent extends SubjectsEvent {
  @override
  List<Object?> get props => [];
}
