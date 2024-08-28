import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/network/dio_client.dart';
import '../../models/groups/add_group_request.dart';
import '../../models/groups/group.dart';

class AdminGroupsService {
  final dio = DioClient.dio;

  /// GET ALL GROUPS
  Future<List<Group>> getAllGroups() async {
    try {
      final response = await dio.get('/groups');
      if (response.statusCode != 200) {
        throw DioException(requestOptions: response.requestOptions);
      }

      List<Group> groups = [];

      if (response.data != null) {
        for (var group in response.data['data']) {
          groups.add(Group.fromJson(group));
        }
      }

      return groups;
    } on DioException catch (e) {
      debugPrint(e.response?.data);
      throw e.response?.data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  /// ADD NEW GROUP
  Future<void> addNewGroup(AddGroupRequest groupData) async {
    try {
      await dio.post(
        '/groups',
        data: groupData.toMap(),
      );
    } on DioException catch (e) {
      debugPrint(e.response?.data);
      throw e.response?.data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  /// DELETE GROUP
  Future<void> deleteGroup({required int groupId}) async {
    try {
      await dio.delete('/groups/$groupId');
    } on DioException catch (e) {
      debugPrint(e.response?.data);
      throw e.response?.data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
