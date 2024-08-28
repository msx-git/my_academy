import '../../../data/models/models.dart';
import '../../../data/services/services.dart';

class UserRepository {
  final UserServiceInterface _userService;

  UserRepository({
    required UserServiceInterface userService,
  }) : _userService = userService;

  Future<User> getUser() async {
    return await _userService.getUser();
  }
}
