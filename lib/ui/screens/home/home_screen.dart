import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                  Container(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
