import 'package:flutter/material.dart';

Widget reusableTextField({
  required TextEditingController controller,
  TextInputType? keyboardType,
  Widget? suffixIcon,
  required bool isPassword,
  required String hint,
  void Function(String)? onFieldSubmitted,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF0F5),
      borderRadius: BorderRadius.circular(20),

      ///SHADOW 
      boxShadow: [
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.15),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),

    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      cursorColor: const Color(0xFFF06292),

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),

        border: InputBorder.none,
        suffixIcon: suffixIcon,
      ),
    ),
  );
}
