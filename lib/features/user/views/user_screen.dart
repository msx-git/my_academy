import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_academy/core/utils/extensions/extensions.dart';
import 'package:my_academy/features/admin/views/widgets/admin_drawer.dart';

import '../../../core/utils/constants/constants.dart';
import '../bloc/user_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final bool isAdmin = state.user!.roleId == 3;
        return Scaffold(
          appBar: AppBar(backgroundColor: AppColors.mainBackground),
          endDrawer: isAdmin ? const AdminDrawer() : null,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 28.w, bottom: 20.h, right: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Profile",
                        style:
                            AppTextStyles.labelNavy.copyWith(fontSize: 30.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 36.r,
                            ),
                            const Spacer(),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(11.w, 9.h, 9.w, 11.h),
                              decoration: BoxDecoration(
                                color: AppColors.mainBackground,
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(Assets.edit),
                            )
                          ],
                        ),
                      ),
                      10.height,
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          state.user!.name,
                          style: AppTextStyles.labelNavy.copyWith(
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          "role: ${state.user!.role.name}",
                          style: AppTextStyles.labelNavy.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
