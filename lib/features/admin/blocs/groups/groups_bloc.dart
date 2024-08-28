import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_academy/domain/repositories/admin_repositories/admin_groups_repository.dart';

import '../../../../data/models/models.dart';

part 'groups_event.dart';

part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final AdminGroupsRepository _adminGroupsRepository;

  GroupsBloc({required AdminGroupsRepository adminGroupsRepository})
      : _adminGroupsRepository = adminGroupsRepository,
        super(GroupsInitialState()) {
    on<GetAllGroupsEvent>(_onGetAllGroups);
    on<DeleteGroupEvent>(_onDeleteGroup);
    on<AddGroupEvent>(_onAddGroup);
  }

  void _onGetAllGroups(event, emit) async {
    emit(GroupsLoadingState());
    try {
      final responseList = await _adminGroupsRepository.getAllGroups();
      emit(GroupsLoadedState(groups: responseList));
    } catch (e) {
      emit(GroupsErrorState(message: e.toString()));
    }
  }

  void _onAddGroup(AddGroupEvent event, emit) async {
    try {
      await _adminGroupsRepository.addNewGroup(event.groupRequest);
      add(GetAllGroupsEvent());
    } catch (e) {
      emit(GroupsErrorState(message: e.toString()));
    }
  }

  void _onDeleteGroup(DeleteGroupEvent event, emit) async {
    try {
      await _adminGroupsRepository.deleteGroup(groupId: event.groupId);
      add(GetAllGroupsEvent());
    } catch (e) {
      emit(GroupsErrorState(message: e.toString()));
    }
  }
}
