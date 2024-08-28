import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_academy/core/utils/extensions/extensions.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/widgets/app_form_widget.dart';
import '../../../data/models/models.dart';
import '../bloc/authentication_bloc.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            50.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.brandIcon),
                16.width,
                Text("My Academy", style: AppTextStyles.logoStyle),
              ],
            ),
            30.height,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow1.withOpacity(0.1036),
                    blurRadius: 58.r,
                    offset: Offset(0, 6.h),
                  )
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: double.infinity),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Sign In to My Academy",
                        style: AppTextStyles.labelNavy,
                      ),
                    ),
                    26.height,

                    /// PHONE INPUT
                    const LabelTitle(label: "Phone Number"),
                    AppFormInput(
                      controller: _phoneController,
                      type: TextInputType.phone,
                      formatters: [
                        LengthLimitingTextInputFormatter(12),
                        CustomPhoneNumberFormatter(),
                      ],
                      action: TextInputAction.next,
                      prefixText: "+998 ",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please, enter phone number.";
                        } else if (("+998${value.trim().replaceAll(' ', '')}")
                                .length !=
                            13) {
                          return "Wrong number format";
                        }
                        return null;
                      },
                    ),
                    16.height,

                    /// PASSWORD INPUT
                    const LabelTitle(label: "Password"),
                    AppFormInput(
                      controller: _passwordController,
                      obscure: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please, enter password.";
                        }
                        return null;
                      },
                    ),
                    25.height,

                    /// FORGOT PASSWORD
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                        ),
                        const Text("Remember me"),
                        const Spacer(),
                        const Text("Forgot Password?")
                      ],
                    ),
                    40.height,

                    /// SIGN IN BUTTON
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final phone =
                              "+998${_phoneController.text.trim().replaceAll(' ', '')}";
                          final password = _passwordController.text.trim();

                          context.read<AuthenticationBloc>().add(
                                LoginEvent(
                                  request: LoginRequest(
                                    phone: phone,
                                    password: password,
                                  ),
                                ),
                              );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: AppColors.blue2,
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blue2.withOpacity(0.26),
                              blurRadius: 12.r,
                              offset: Offset(0, 6.h),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sign In", style: AppTextStyles.whiteText),
                            7.width,
                            SizedBox(
                              height: 24.h,
                              width: 24.w,
                              child: SvgPicture.asset(Assets.arrowRight),
                            )
                          ],
                        ),
                      ),
                    ),
                    20.height,

                    /// JUMP TO REGISTER
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Don’t have an account?",
                          style: AppTextStyles.blueText,
                        ),
                      ),
                    ),
                    20.height,
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Or sign in with social account",
                      ),
                    ),
                    10.height,

                    /// SOCIAL LOGINS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// GOOGLE
                        FlutterSocialButton(
                          mini: true,
                          onTap: () {
                            context.read<AuthenticationBloc>().add(
                                SocialLoginEvent(
                                    type: SocialLoginTypes.google));
                          },
                          buttonType: ButtonType.google,
                          title: "Sign in with Google",
                        ),

                        /// FACEBOOK
                        FlutterSocialButton(
                          mini: true,
                          onTap: () {
                            context.read<AuthenticationBloc>().add(
                                SocialLoginEvent(
                                    type: SocialLoginTypes.facebook));
                          },
                          buttonType: ButtonType.facebook,
                          title: "Sign in with Google",
                        ),

                        /// GITHUB
                        FlutterSocialButton(
                          mini: true,
                          onTap: () {
                            context.read<AuthenticationBloc>().add(
                                SocialLoginEvent(
                                    type: SocialLoginTypes.github));
                          },
                          buttonType: ButtonType.github,
                          title: "Sign in with Google",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
