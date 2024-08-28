import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static final logoStyle = GoogleFonts.nunitoSans(
    color: AppColors.blue1,
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
  );

  static final labelNavy = GoogleFonts.nunitoSans(
    color: AppColors.darkNavy,
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
  );

  static final hintLabel = GoogleFonts.nunitoSans(
    color: AppColors.grey1,
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
  );
  static final hint = GoogleFonts.nunitoSans(
    color: AppColors.grey1,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  );
  static final whiteText = GoogleFonts.nunitoSans(
    color: AppColors.white,
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
  );
  static final blueText = GoogleFonts.nunitoSans(
    color: AppColors.blue2,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );
}
