part of 'user_bloc.dart';

sealed class UserEvent {}

final class GetCurrentUserEvent extends UserEvent {}