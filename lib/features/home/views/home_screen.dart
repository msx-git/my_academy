import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_academy/core/utils/extensions/extensions.dart';

import '../../../core/utils/constants/constants.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../user/bloc/user_bloc.dart';
import '../../user/views/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                          builder: (context) => const UserScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text(
                            state.user!.name[0],
                            style: const TextStyle(color: AppColors.white),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///
            TextButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(LogoutEvent());
              },
              child: const Text("LOG OUT"),
            ),
          ],
        ),
      ),
    );
  }
}
