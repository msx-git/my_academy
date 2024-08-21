import 'package:my_academy/data/services/auth_service.dart';

import '../models/register_request.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({required AuthService authService})
      : _authService = authService;

  /// SIGN UP
  Future<Map<String, dynamic>> signUp(RegisterRequest request) async {
    return _authService.signUp(request);
  }

  /// SIGN IN
  Future<Map<String, dynamic>> signIn(String phone, String password) async {
    return _authService.signIn(phone, password);
  }

  /// SIGN OUT
  Future<void> signOut() async {
    await _authService.signOut();
  }
}
