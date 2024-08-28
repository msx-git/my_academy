import 'package:dio/dio.dart';
import 'package:my_academy/data/models/models.dart';

import '../../../core/utils/network/dio_client.dart';

class AdminUsersService {
  final dio = DioClient.dio;

  /// GET ALL USERS
  Future<List<User>> getAllUsers() async {
    try {
      final response = await dio.get('/users');
      if (response.statusCode != 200) {
        throw DioException(requestOptions: response.requestOptions);
      }

      List<User> users = [];

      if (response.data != null) {
        for (var user in response.data['data']) {
          users.add(User.fromJson(user));
        }
      }
      return users;
    } on DioException catch (e) {
      throw e.response?.data;
    } catch (e) {
      rethrow;
    }
  }
}
