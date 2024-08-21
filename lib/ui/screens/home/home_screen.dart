import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';
import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/cubits/user_cubit.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String? token;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    token = await SharedPrefs.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().getUserFromPrefs();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// APPBAR
            Container(
              margin: EdgeInsets.all(10.r),
              padding: EdgeInsets.fromLTRB(15.w, 15.h, 20.w, 15.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffC4CBD6).withOpacity(0.1),
                    blurRadius: 58.r,
                    offset: Offset(0, 6.h),
                  )
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 40.w,
                    child: SvgPicture.asset(Assets.brandIcon),
                  ),
                  const Spacer(),
                  SvgPicture.asset(Assets.search),
                  24.width,
                  SvgPicture.asset(Assets.notification),
                  24.width,
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: randomColor(),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "M",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignOutEvent(context: context));
                  context.read<UserBloc>().clearUserData();
                },
                child: const Text("LOG OUT")),
            Padding(
              padding: EdgeInsets.only(left: 28.w, top: 20.h),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserInitial) {
                    return const CircularProgressIndicator();
                  } else if (state is UserLoaded) {
                    return Text(
                      'Welcome back, ${state.user.name}!',
                      style: AppTextStyles.hint.copyWith(fontSize: 16.sp),
                    );
                  } else if (state is UserError) {
                    return Text('Error: ${state.error}');
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
