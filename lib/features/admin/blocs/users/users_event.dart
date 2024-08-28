part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();
}

final class GetUsersEvent extends UsersEvent {
  @override
  List<Object?> get props => [];
}
