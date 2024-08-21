import 'package:bloc/bloc.dart';
import 'package:my_academy/core/core.dart';

import '../../data/models/user.dart';

part 'user_state.dart';

class UserBloc extends Cubit<UserState> {
  UserBloc() : super(UserInitial());

  // Load user from API response and save to SharedPreferences
  void loadUser(Map<String, dynamic> jsonData) async {
    try {
      final user = User.fromJson(jsonData['data']);
      await SharedPrefs.saveUser(user);
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserError(error: 'Failed to load user data'));
    }
  }

  // Retrieve user from SharedPreferences
  void getUserFromPrefs() async {
    try {
      final user = await SharedPrefs.getUser();
      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(UserInitial()); // or handle as necessary
      }
    } catch (e) {
      emit(UserError(error: 'Failed to retrieve user data'));
    }
  }

  // Clear user data
  void clearUserData() async {
    await SharedPrefs.clearUser();
    emit(UserInitial());
  }
}
