import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/wife_reg_controller.dart';
import '../../../utils/app_tags.dart';
import '../../../utils/validators.dart';

class StepOne extends StatelessWidget {
  final WifeRegistrationController controller;
  const StepOne({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 0.0: 4.w),
            child: Text(
              "Login information",
              style: TextStyle(
                fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.sp: 5.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: controller.firstNameController,
                  textAlign: TextAlign.center,
                  validator: (String? value) {
                    return validateNotEmpty(value!, AppTags.firstName.tr);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: AppTags.firstName.tr,
                    hintStyle: const TextStyle(
                      color: Color(0xffC0B4CC),
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.lastNameController,
                  textAlign: TextAlign.center,
                  validator: (String? value) {
                    return validateNotEmpty(value!, AppTags.lastName.tr);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: AppTags.lastName.tr,
                    hintStyle: const TextStyle(
                      color: Color(0xffC0B4CC),
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.userNameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: AppTags.userName.tr,
                    hintStyle: const TextStyle(
                      color: Color(0xffC0B4CC),
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.emailController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: AppTags.emailAddress.tr,
                    hintStyle: const TextStyle(
                      color: Color(0xffC0B4CC),
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.passwordController,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppTags.password.tr,
                    hintStyle: const TextStyle(
                      color: Color(0xffC0B4CC),
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.confirmPassController,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    hintStyle: const TextStyle(
                      color: Color(0xffC0B4CC),
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
