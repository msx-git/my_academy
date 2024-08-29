import 'package:get_it/get_it.dart';
import 'package:my_academy/data/services/admin/admin_groups_service.dart';
import 'package:my_academy/data/services/admin/admin_subjects_service.dart';
import 'package:my_academy/data/services/admin/admin_users_service.dart';
import 'package:my_academy/data/services/admin/admins_rooms_service.dart';
import 'package:my_academy/domain/repositories/admin_repositories/admin_groups_repository.dart';
import 'package:my_academy/domain/repositories/admin_repositories/admin_rooms_repository.dart';
import 'package:my_academy/domain/repositories/admin_repositories/admin_subjects_repository.dart';
import 'package:my_academy/domain/repositories/admin_repositories/admin_users_repository.dart';
import 'package:my_academy/features/admin/blocs/groups/groups_bloc.dart';
import 'package:my_academy/features/admin/blocs/subjects/subjects_bloc.dart';
import 'package:my_academy/features/admin/blocs/users/users_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/services/services.dart';
import '../../domain/repositories/repositories.dart';
import '../../features/admin/blocs/rooms/rooms_bloc.dart';
import '../../features/authentication/bloc/authentication_bloc.dart';
import '../../features/user/bloc/user_bloc.dart';

final getIt = GetIt.instance;

Future<void> dependencySetUp() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  /// SERVICES
  getIt.registerSingleton(AuthenticationService());
  getIt.registerSingleton(LocalAuthenticationService());
  getIt.registerSingleton(UserService());
  getIt.registerSingleton(AdminUsersService());
  getIt.registerSingleton(AdminGroupsService());
  getIt.registerSingleton(AdminSubjectsService());
  getIt.registerSingleton(AdminRoomsService());

  /// REPOSITORIES
  getIt.registerSingleton(
    AuthenticationRepository(
        authenticationService: getIt.get<AuthenticationService>(),
        localAuthenticationService: getIt.get<LocalAuthenticationService>()),
  );
  getIt.registerSingleton(
    UserRepository(userService: getIt.get<UserService>()),
  );
  getIt.registerSingleton(
      AdminUsersRepository(adminUsersService: getIt.get<AdminUsersService>()));
  getIt.registerSingleton(AdminGroupsRepository(
      adminGroupsService: getIt.get<AdminGroupsService>()));
  getIt.registerSingleton(AdminSubjectsRepository(
      adminSubjectsService: getIt.get<AdminSubjectsService>()));
  getIt.registerSingleton(
      AdminRoomsRepository(adminsRoomsService: getIt.get<AdminRoomsService>()));

  /// BLOCS  [LAZY]
  getIt.registerLazySingleton<UserBloc>(
    () => UserBloc(
      userRepository: getIt.get<UserRepository>(),
    ),
  );
  getIt.registerLazySingleton<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: getIt.get<AuthenticationRepository>(),
    )..add(CheckAuthStatusEvent()),
  );
  getIt.registerLazySingleton(
    () => UsersBloc(adminUsersRepository: getIt.get<AdminUsersRepository>())
      ..add(GetUsersEvent()),
  );
  getIt.registerLazySingleton(() =>
      GroupsBloc(adminGroupsRepository: getIt.get<AdminGroupsRepository>()));
  getIt.registerLazySingleton(() => SubjectsBloc(
      adminSubjectsRepository: getIt.get<AdminSubjectsRepository>()));
  getIt.registerLazySingleton(
      () => RoomsBloc(adminRoomsRepository: getIt.get<AdminRoomsRepository>()));
}
