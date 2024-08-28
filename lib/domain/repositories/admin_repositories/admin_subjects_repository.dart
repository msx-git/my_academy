import 'package:my_academy/data/services/admin/admin_subjects_service.dart';

import '../../../data/models/subject/subject.dart';

class AdminSubjectsRepository {
  final AdminSubjectsService _adminSubjectsService;

  AdminSubjectsRepository({required AdminSubjectsService adminSubjectsService})
      : _adminSubjectsService = adminSubjectsService;

  /// GET ALL SUBJECTS
  Future<List<Subject>> getAllSubjects() async {
    return await _adminSubjectsService.getAllSubjects();
  }
}
