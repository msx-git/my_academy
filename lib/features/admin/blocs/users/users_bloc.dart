import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_academy/domain/repositories/admin_repositories/admin_users_repository.dart';

import '../../../../data/models/user/user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final AdminUsersRepository _adminUsersRepository;

  UsersBloc({required AdminUsersRepository adminUsersRepository})
      : _adminUsersRepository = adminUsersRepository,
        super(UsersInitialState()) {
    on<GetUsersEvent>(_onGetAllUsers);
  }

  void _onGetAllUsers(GetUsersEvent event, Emitter<UsersState> emit) async {
    emit(UsersLoadingState());
    try {
      final responseList = await _adminUsersRepository.getAllUsers();
      emit(UsersLoadedState(users: responseList));
    } catch (e) {
      emit(UsersErrorState(message: e.toString()));
    }
  }
}
