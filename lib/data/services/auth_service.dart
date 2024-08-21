import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_academy/logic/cubits/user_cubit.dart';

import '../../core/network/dio_client.dart';
import '../../core/utils/shared_prefs.dart';
import '../models/register_request.dart';

class AuthService {
  final _dio = DioClient();

  /// SIGN UP
  Future<Map<String, dynamic>> signUp(RegisterRequest request) async {
    try {
      final response = await _dio.post(
        path: '/register',
        data: request.toMap(),
      );
      final data = _handleResponse(response);
      await SharedPrefs.saveAccessToken(data['data']['token']);
      await getUser();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  /// SIGN IN
  Future<Map<String, dynamic>> signIn(String phone, String password) async {
    try {
      final response = await _dio.post(
        path: '/login',
        data: {
          'phone': phone,
          'password': password,
        },
      );
      final data = _handleResponse(response);
      await SharedPrefs.saveAccessToken(data['data']['token'].toString());
      await getUser();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  /// SIGN OUT
  Future<void> signOut() async {
    try {
      final response = await _dio.post(
        path: '/logout',
      );

      if (response.statusCode == 200) {
        await SharedPrefs.clearAccessToken();
      } else {
        throw Exception('Failed to sign out: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// GET USER
  Future<void> getUser() async {
    try {
      final response = await _dio.get(
        path: '/user',
      );
      if(response.statusCode == 200){
        final data = _handleResponse(response);
        final userBloc = UserBloc();
        userBloc.loadUser(data);
        debugPrint("GET USER: ${data.toString()}");
      } else{
        throw Exception("Couldn't get User data: ${response.data}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    final Map<String, dynamic> decoded = response.data;
    if (response.statusCode != 200) {
      throw Exception('Failed request: ${decoded['message']}');
    }
    return decoded;
  }
}
