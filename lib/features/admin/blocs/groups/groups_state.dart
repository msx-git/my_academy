part of 'groups_bloc.dart';

sealed class GroupsState extends Equatable {
  const GroupsState();
}

final class GroupsInitialState extends GroupsState {
  @override
  List<Object> get props => [];
}

final class GroupsLoadingState extends GroupsState {
  @override
  List<Object> get props => [];
}

final class GroupsLoadedState extends GroupsState {
  final List<Group> groups;

  const GroupsLoadedState({required this.groups});

  @override
  List<Object> get props => [groups];
}

final class GroupsErrorState extends GroupsState {
  final String message;

  const GroupsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
