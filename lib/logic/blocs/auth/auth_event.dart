part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class SignUpEvent extends AuthEvent {
  @override
  List<Object> get props => [request, context];

  final RegisterRequest request;
  final BuildContext context;

  const SignUpEvent({required this.request, required this.context});
}

final class SignInEvent extends AuthEvent {
  @override
  List<Object> get props => [phone, password];

  final String phone;
  final String password;
  final BuildContext context;

  const SignInEvent(
      {required this.phone, required this.password, required this.context});
}

final class SignOutEvent extends AuthEvent {
  @override
  List<Object> get props => [accessToken];

  final String accessToken;
  final BuildContext context;

  const SignOutEvent({required this.accessToken, required this.context});
}
