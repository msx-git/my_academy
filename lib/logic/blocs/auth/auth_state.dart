part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class InitialAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

final class LoadingAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthenticatedAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

final class UnAuthenticatedAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

final class ErrorAuthState extends AuthState {
  @override
  List<Object> get props => [];
  final String errorMessage;

  const ErrorAuthState({required this.errorMessage});
}
