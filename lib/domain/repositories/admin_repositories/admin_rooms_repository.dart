import 'package:my_academy/data/services/admin/admins_rooms_service.dart';

import '../../../data/models/room/room.dart';

class AdminRoomsRepository {
  final AdminRoomsService _adminsRoomsService;

  AdminRoomsRepository({required AdminRoomsService adminsRoomsService})
      : _adminsRoomsService = adminsRoomsService;

  /// GET ALL ROOMS
  Future<List<Room>> getAllRooms() async {
    return await _adminsRoomsService.getAllRooms();
  }
}
