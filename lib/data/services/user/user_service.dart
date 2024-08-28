import 'package:dio/dio.dart';

import '../../../core/utils/network/dio_client.dart';
import '../../models/models.dart';

abstract class UserServiceInterface {
  Future<User> getUser();
}

class UserService extends UserServiceInterface {
  final dio = DioClient.dio;

  @override
  Future<User> getUser() async {
    try {
      final response = await dio.get('/user');
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw e.response?.data;
    } catch (e) {
      rethrow;
    }
  }

}
