import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/register_request.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../ui/screens/auth/sign_in_screen.dart';
import '../../../ui/screens/home/home_screen.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(InitialAuthState()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
  }

  void _onSignUp(SignUpEvent event, emit) async {
    emit(LoadingAuthState());
    try {
      final response = await _authRepository.signUp(event.request);
      debugPrint("Register bloc response: $response");
      emit(AuthenticatedAuthState());
      // Navigate to HomeScreen after successful sign-up
      Navigator.pushReplacement(
        event.context,
        CupertinoPageRoute(builder: (context) => const HomeScreen()),
      );
    } on DioException catch (e) {
      emit(ErrorAuthState(errorMessage: e.toString()));
    } catch (e) {
      emit(ErrorAuthState(errorMessage: e.toString()));
    }
  }

  void _onSignIn(SignInEvent event, emit) async {
    emit(LoadingAuthState());
    try {
      final response =
          await _authRepository.signIn(event.phone, event.password);
      debugPrint("Signin bloc response: $response");
      emit(AuthenticatedAuthState());
      // Navigate to HomeScreen after successful sign-in
      Navigator.pushReplacement(
        event.context,
        CupertinoPageRoute(builder: (context) => const HomeScreen()),
      );
    } on DioException catch (e) {
      emit(ErrorAuthState(errorMessage: e.toString()));
    } catch (e) {
      emit(ErrorAuthState(errorMessage: e.toString()));
    }
  }

  void _onSignOut(SignOutEvent event, emit) async {
    emit(LoadingAuthState());
    try {
      _authRepository.signOut();
      emit(UnAuthenticatedAuthState());
      // Navigate to SignInScreen after successful sign-out
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    } on DioException catch (e) {
      emit(ErrorAuthState(errorMessage: e.toString()));
    } catch (e) {
      emit(ErrorAuthState(errorMessage: e.toString()));
    }
  }
}
