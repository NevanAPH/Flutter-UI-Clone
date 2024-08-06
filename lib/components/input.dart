import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import utilities
import '/utils/colors.dart';

class PrimaryInput extends StatelessWidget {
  final TextEditingController? controller;
  final bool readOnly;
  final bool obscureText;
  final TextStyle style;
  final List<TextInputFormatter>? inputFormatters;

  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;

  const PrimaryInput(
      {super.key,
      this.controller,
      this.readOnly = false,
      this.obscureText = false,
      this.style = const TextStyle(color: Colors.white),
      this.inputFormatters,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      style: style,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: ThemeColor.input,
        errorText: errorText,
        errorStyle: TextStyle(
            color: ThemeColor.error,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: errorText == null
              ? BorderSide.none
              : BorderSide(color: ThemeColor.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
