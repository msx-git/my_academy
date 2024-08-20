import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/core.dart';

class AppFormInput extends StatelessWidget {
  const AppFormInput({
    super.key,
    required this.controller,
    this.validator,
    this.obscure = false,
    this.hintText,
    this.type,
    this.action,
    this.prefixText,
    this.formatters,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? prefixText;
  final bool obscure;
  final TextInputType? type;
  final TextInputAction? action;
  final List<TextInputFormatter>? formatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscure,
      keyboardType: type,
      textInputAction: action,
      inputFormatters: formatters,
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
        color: AppColors.grey1,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.hint,
        prefixText: prefixText,

        /// Borders
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.border, width: 1.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.border, width: 1.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.grey1, width: 1.r),
        ),
      ),
    );
  }
}

class CustomPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove all non-digit characters
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Format the digits into the desired pattern
    String formattedText = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      formattedText += digitsOnly[i];
      if (i == 1 || i == 4 || i == 6) {
        formattedText += ' ';
      }
    }

    // Calculate the new cursor position
    int cursorPosition = newValue.selection.end;

    // Adjust the cursor position if a space was added
    if (cursorPosition > 0 &&
        digitsOnly.length <
            oldValue.text.replaceAll(RegExp(r'\D'), '').length) {
      if (oldValue.text[cursorPosition - 1] == ' ') {
        cursorPosition -= 1;
      }
    } else if (cursorPosition < formattedText.length &&
        (formattedText[cursorPosition - 1] == ' ')) {
      cursorPosition += 1;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
