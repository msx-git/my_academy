import 'dart:async';

import '../../../data/models/models.dart';
import '../../../data/services/services.dart';

class AuthenticationRepository {
  final AuthenticationServiceInterface _authenticationService;
  final LocalAuthenticationService _localAuthenticationService;

  AuthenticationRepository({
    required AuthenticationServiceInterface authenticationService,
    required LocalAuthenticationService localAuthenticationService,
  })  : _authenticationService = authenticationService,
        _localAuthenticationService = localAuthenticationService;

  Future<void> login(LoginRequest request) async {
    final response = await _authenticationService.login(request);
    await _localAuthenticationService.saveAuth(response);
  }

  Future<void> socialLogin(SocialLoginRequest request) async {
    final response = await _authenticationService.socialLogin(request);
    await _localAuthenticationService.saveAuth(response);
  }

  Future<void> register(RegisterRequest request) async {
    final response = await _authenticationService.register(request);
    await _localAuthenticationService.saveAuth(response);
  }

  Future<void> logout() async {
    await _authenticationService.logout();
    await _localAuthenticationService.deleteAuth();
  }

  Future<bool> checkAuthStatus() async {
    final auth = _localAuthenticationService.getAuth();
    return auth != null;
  }
}
