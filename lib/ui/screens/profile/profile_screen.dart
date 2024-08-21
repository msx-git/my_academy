import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_academy/core/core.dart';

import '../../../logic/cubits/user_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h, left: 28.w,bottom: 20.h),
              child: Text(
                "My Profile",
                style: AppTextStyles.labelNavy.copyWith(fontSize: 30.sp),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColors.white,

              ),
              alignment: Alignment.center,
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
            ),
          ],
        ),
      ),
    );
  }
}
