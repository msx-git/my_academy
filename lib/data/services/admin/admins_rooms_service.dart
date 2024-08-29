import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_academy/core/utils/network/dio_client.dart';
import 'package:my_academy/data/models/models.dart';

class AdminRoomsService {
  final dio = DioClient.dio;

  /// GET ALL ROOMS
  Future<List<Room>> getAllRooms() async {
    try {
      final response = await dio.get('/rooms');
      if (response.statusCode != 200) {
        throw DioException(requestOptions: response.requestOptions);
      }

      List<Room> rooms = [];

      if (response.data != null) {
        for (var room in response.data['data']) {
          rooms.add(Room.fromJson(room));
        }
      }
      return rooms;
    } on DioException catch (e) {
      debugPrint(e.response?.data);
      throw e.response?.data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
