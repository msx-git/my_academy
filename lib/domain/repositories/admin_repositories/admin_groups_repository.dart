import '../../../data/models/models.dart';
import '../../../data/services/admin/admin_groups_service.dart';

class AdminGroupsRepository {
  final AdminGroupsService _adminGroupsService;

  AdminGroupsRepository({required AdminGroupsService adminGroupsService})
      : _adminGroupsService = adminGroupsService;

  /// GET ALL GROUPS
  Future<List<Group>> getAllGroups() async {
    return await _adminGroupsService.getAllGroups();
  }

  /// ADD NEW GROUP
  Future<void> addNewGroup(AddGroupRequest groupData) async {
    await _adminGroupsService.addNewGroup(groupData);
  }

  /// DELETE GROUP
  Future<void> deleteGroup({required int groupId}) async {
    await _adminGroupsService.deleteGroup(groupId: groupId);
  }
}
