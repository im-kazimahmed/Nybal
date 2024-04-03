import 'package:flutter/material.dart';
import 'package:nybal/Widgets/theme_data.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final Icon? suffixIcon;
  final int maxLength;
  final bool isPasswordField;
  final bool? isPasswordVisible;
  final Function? suffixOnTap;
  const CustomInput(
      {super.key,
        required this.controller,
        required this.label,
        required this.isPasswordField,
        this.isPasswordVisible,
        this.hint = "example@gmail.com",
        this.suffixIcon,
        this.maxLength = 1,
        this.suffixOnTap,
      });

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return '$label is required';
    }
    return null; // Input is valid
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPasswordField,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xffC0B4CC),
        ),
        suffixIcon: isPasswordField ? GestureDetector(
          onTap: () => suffixOnTap,
          child: isPasswordVisible! ? const Icon(
            Icons.visibility_off_outlined,
            color: AppColors.pinkButton,
          ): const Icon(
            Icons.visibility_outlined,
            color: Colors.deepPurple,
          ),
        ): null,
        filled: true,
        fillColor: Colors.blueGrey[50],
        labelStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.only(left: 30),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[50]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[50]!),
        ),
      ),
    );
    // return Container(
    //   width: Get.width,
    //   // height:Get.height*0.05,
    //   padding: EdgeInsets.symmetric(horizontal: 20),
    //   child: TextFormField(
    //     controller: controller,
    //     maxLines: maxLength,
    //     validator: _validateInput,
    //     autovalidateMode: AutovalidateMode.onUserInteraction,
    //     decoration: InputDecoration(
    //       alignLabelWithHint: true,
    //       label: Text(
    //         label,
    //         style: TextStyle(
    //             color: Colors.black,
    //             fontWeight: FontWeight.w600,
    //             fontSize: 16),
    //       ),
    //       hintText: hint,
    //       suffixIcon: suffixIcon,
    //       errorStyle: TextStyle(color: Colors.black),
    //     ),
    //   ),
    // );
  }
}
