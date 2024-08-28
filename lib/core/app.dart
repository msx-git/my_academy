import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/authentication/bloc/authentication_bloc.dart';
import '../features/authentication/views/sign_in_screen.dart';
import '../features/home/views/home_screen.dart';
import '../features/user/bloc/user_bloc.dart';
import 'utils/constants/app_colors.dart';
import 'utils/helpers/dialogs.dart';
import 'utils/providers.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: ScreenUtilInit(
        designSize: const Size(350, 800),
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.mainBackground,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.mainBackground,
              ),
            ),
            home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.isLoading) {
                  AppDialogs.showLoading(context);
                } else {
                  AppDialogs.hideLoading(context);

                  if (state.error != null) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text(state.error.toString())),
                      );
                  }
                }

                if (state.status == AuthenticationStatus.authenticated) {
                  context.read<UserBloc>().add(GetCurrentUserEvent());
                }
              },
              builder: (context, state) {
                if (state.status == AuthenticationStatus.authenticated) {
                  return const HomeScreen();
                }

                return const SignInScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
