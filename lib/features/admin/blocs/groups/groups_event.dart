part of 'groups_bloc.dart';

sealed class GroupsEvent extends Equatable {
  const GroupsEvent();
}

final class GetAllGroupsEvent extends GroupsEvent {
  @override
  List<Object?> get props => [];
}

final class AddGroupEvent extends GroupsEvent {
  final AddGroupRequest groupRequest;

  const AddGroupEvent({required this.groupRequest});

  @override
  List<Object?> get props => [groupRequest];
}

final class DeleteGroupEvent extends GroupsEvent {
  final int groupId;

  const DeleteGroupEvent({required this.groupId});

  @override
  List<Object?> get props => [groupId];
}
