import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_academy/data/models/models.dart';

import '../../../core/utils/network/dio_client.dart';

class AdminSubjectsService {
  final dio = DioClient.dio;

  /// GET ALL SUBJECTS
  Future<List<Subject>> getAllSubjects() async {
    try {
      final response = await dio.get('/subjects');
      if (response.statusCode != 200) {
        throw DioException(requestOptions: response.requestOptions);
      }

      List<Subject> subjects = [];

      if (response.data != null) {
        for (var subject in response.data['data']) {
          subjects.add(Subject.fromJson(subject));
        }
      }
      return subjects;
    } on DioException catch (e) {
      debugPrint(e.response?.data);
      throw e.response?.data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
