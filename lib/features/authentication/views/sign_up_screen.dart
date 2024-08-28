import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_academy/core/utils/extensions/extensions.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/widgets/app_form_widget.dart';
import '../../../data/models/auth/register_request.dart';
import '../bloc/authentication_bloc.dart';
import 'sign_up_screen_admin_teacher.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: ListView(
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
                        "Sign Up to My Academy",
                        style: AppTextStyles.labelNavy,
                      ),
                    ),
                    26.height,

                    /// NAME INPUT
                    const LabelTitle(label: "Name"),
                    AppFormInput(
                      controller: _nameController,
                      action: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please, enter name.";
                        }
                        return null;
                      },
                    ),
                    16.height,

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
                      action: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please, enter password.";
                        }
                        return null;
                      },
                    ),
                    16.height,

                    /// PASSWORD CONFIRM INPUT
                    const LabelTitle(label: "Password Confirm"),
                    AppFormInput(
                      controller: _passwordConfirmController,
                      obscure: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please, enter password.";
                        } else if (_passwordConfirmController.text.trim() !=
                            _passwordController.text.trim()) {
                          return "Passwords didn't match.";
                        }
                        return null;
                      },
                    ),
                    25.height,

                    /// SIGN UP BUTTON
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final name = _nameController.text.trim();
                          final phone =
                              "+998${_phoneController.text.trim().replaceAll(' ', '')}";
                          final password = _passwordController.text.trim();
                          final confirmPassword =
                              _passwordConfirmController.text.trim();

                          context.read<AuthenticationBloc>().add(
                                RegisterEvent(
                                  request: RegisterRequest(
                                    name: name,
                                    phone: phone,
                                    password: password,
                                    passwordConfirmation: confirmPassword,
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
                            Text("Sign Up", style: AppTextStyles.whiteText),
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

                    /// ADMIN REGISTER
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                const SignUpScreenAdminTeacher(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "You are not a student?",
                          style: AppTextStyles.blueText,
                        ),
                      ),
                    )
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

class LabelTitle extends StatelessWidget {
  const LabelTitle({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w, bottom: 7.h),
      child: Text(
        label,
        style: AppTextStyles.hintLabel,
      ),
    );
  }
}
