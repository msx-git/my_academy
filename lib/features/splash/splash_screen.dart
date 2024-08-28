import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_academy/core/utils/extensions/extensions.dart';
import 'package:my_academy/features/authentication/views/sign_in_screen.dart';

import '../../core/utils/constants/constants.dart';
import '../../core/utils/helpers/dialogs.dart';
import '../authentication/bloc/authentication_bloc.dart';
import '../home/views/home_screen.dart';
import '../user/bloc/user_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          Text(
            "My Academy",
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: AppColors.blue1,
            ),
          ),
          16.height,
          Lottie.asset(
            Assets.loadingSplash,
            height: 250.h,
          ),
          Lottie.asset(
            Assets.loadingText,
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().whenComplete(
                  () {
                    Navigator.pushReplacement(context, CupertinoPageRoute(
                      builder: (context) {
                        return BlocConsumer<AuthenticationBloc,
                            AuthenticationState>(
                          listener: (context, state) {
                            if (state.isLoading) {
                              AppDialogs.showLoading(context);
                            } else {
                              AppDialogs.hideLoading(context);

                              if (state.error != null) {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                        content: Text(state.error.toString())),
                                  );
                              }
                            }

                            if (state.status ==
                                AuthenticationStatus.authenticated) {
                              context
                                  .read<UserBloc>()
                                  .add(GetCurrentUserEvent());
                            }
                          },
                          builder: (context, state) {
                            if (state.status ==
                                AuthenticationStatus.authenticated) {
                              return const HomeScreen();
                            }

                            return const SignInScreen();
                          },
                        );
                      },
                    ));
                  },
                );
            },
          )
        ],
      ),
    );
  }
}
