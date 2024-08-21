part of 'user_cubit.dart';
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({required this.user});
}

class UserError extends UserState {
  final String error;

  UserError({required this.error});
}