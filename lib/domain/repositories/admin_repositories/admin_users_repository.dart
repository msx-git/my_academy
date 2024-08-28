import 'package:my_academy/data/services/admin/admin_users_service.dart';

import '../../../data/models/user/user.dart';

class AdminUsersRepository {
  final AdminUsersService _adminUsersService;

  AdminUsersRepository({required AdminUsersService adminUsersService})
      : _adminUsersService = adminUsersService;

  Future<List<User>> getAllUsers() async {
    return await _adminUsersService.getAllUsers();
  }
}
