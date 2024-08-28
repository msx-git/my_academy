part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();
}

final class UsersInitialState extends UsersState {
  @override
  List<Object> get props => [];
}

final class UsersLoadingState extends UsersState {
  @override
  List<Object> get props => [];
}

final class UsersLoadedState extends UsersState {
  final List<User> users;

  const UsersLoadedState({required this.users});

  @override
  List<Object> get props => [users];
}

final class UsersErrorState extends UsersState {
  final String message;

  const UsersErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
