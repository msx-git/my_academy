import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_academy/core/core.dart';

import '../../../data/models/register_request.dart';
import '../../../logic/blocs/blocs.dart';
import '../../widgets/widgets.dart';
import 'sign_up_screen.dart';

class SignUpScreenAdminTeacher extends StatefulWidget {
  const SignUpScreenAdminTeacher({super.key});

  @override
  State<SignUpScreenAdminTeacher> createState() =>
      _SignUpScreenAdminTeacherState();
}

class _SignUpScreenAdminTeacherState extends State<SignUpScreenAdminTeacher> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  String _selectedRole = 'Teacher'; // Default role

  void _onRoleSelected(String role) {
    setState(() {
      _selectedRole = role;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _selectedRole,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

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
                  10.height,
                  RoleSelectionWidget(onRoleSelected: _onRoleSelected),
                  10.height,

                  /// SIGN UP BUTTON
                  GestureDetector(
                    onTap: () {
                      print(
                          ("+998${_phoneController.text.trim().replaceAll(' ', '')}"));
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignUpEvent(
                                request: RegisterRequest(
                                  name: _nameController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  passwordConfirmation:
                                      _passwordConfirmController.text.trim(),
                                  roleId: _selectedRole == "Teacher" ? 2 : 3,
                                ),
                                context: context,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoleSelectionWidget extends StatefulWidget {
  final Function(String) onRoleSelected;

  const RoleSelectionWidget({super.key, required this.onRoleSelected});

  @override
  State<RoleSelectionWidget> createState() => _RoleSelectionWidgetState();
}

class _RoleSelectionWidgetState extends State<RoleSelectionWidget> {
  String _selectedRole = 'Teacher'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Select your role:',
        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        // ),
        // SizedBox(height: 10),
        RadioListTile<String>(
          title: const Text('Teacher'),
          value: 'Teacher',
          groupValue: _selectedRole,
          onChanged: (value) {
            setState(() {
              _selectedRole = value!;
            });
            widget.onRoleSelected(_selectedRole); // Notify the parent widget
          },
        ),
        RadioListTile<String>(
          title: const Text('Admin'),
          value: 'Admin',
          groupValue: _selectedRole,
          onChanged: (value) {
            setState(() {
              _selectedRole = value!;
            });
            widget.onRoleSelected(_selectedRole); // Notify the parent widget
          },
        ),
      ],
    );
  }
}
