part of 'subjects_bloc.dart';

sealed class SubjectsState extends Equatable {
  const SubjectsState();
}

final class SubjectsInitialState extends SubjectsState {
  @override
  List<Object> get props => [];
}

final class SubjectsLoadingState extends SubjectsState {
  @override
  List<Object> get props => [];
}

final class SubjectsLoadedState extends SubjectsState {
  final List<Subject> subjects;

  const SubjectsLoadedState({required this.subjects});

  @override
  List<Object> get props => [subjects];
}

final class SubjectsErrorState extends SubjectsState {
  final String message;

  const SubjectsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
