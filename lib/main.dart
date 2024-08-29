import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_academy/data/services/admin/admin_groups_service.dart';
import 'package:my_academy/data/services/admin/admin_subjects_service.dart';
import 'package:my_academy/data/services/admin/admin_users_service.dart';
import 'package:my_academy/data/services/admin/admins_rooms_service.dart';

import 'core/app.dart';
import 'core/utils/locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dependencySetUp();
  final admin = AdminRoomsService();
  admin.getAllRooms();
  runApp(const MainApp());
}
