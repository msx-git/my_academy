import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/core.dart';
import '../auth/sign_in_screen.dart';
import '../home/home_screen.dart';

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
                    _checkLoginStatus();
                  },
                );
            },
          )
        ],
      ),
    );
  }

  Future<void> _checkLoginStatus() async {
    final accessToken = await SharedPrefs.getAccessToken();
    if (accessToken != null) {
      // User is logged in, navigate to HomeScreen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } else {
      // User is not logged in, navigate to SignInScreen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );
      }
    }
  }
}
