import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_academy/features/admin/blocs/groups/groups_bloc.dart';
import 'package:my_academy/features/admin/blocs/subjects/subjects_bloc.dart';
import 'package:my_academy/features/admin/blocs/users/users_bloc.dart';

import '../../features/authentication/bloc/authentication_bloc.dart';
import '../../features/user/bloc/user_bloc.dart';
import 'locator.dart';

final providers = [
  BlocProvider<UserBloc>.value(value: getIt.get<UserBloc>()),
  BlocProvider<AuthenticationBloc>.value(
      value: getIt.get<AuthenticationBloc>()),
  BlocProvider<UsersBloc>.value(value: getIt.get<UsersBloc>()),
  BlocProvider<GroupsBloc>.value(value: getIt.get<GroupsBloc>()),
  BlocProvider<SubjectsBloc>.value(value: getIt.get<SubjectsBloc>()),
];
