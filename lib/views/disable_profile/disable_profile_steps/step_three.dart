import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/custom_drop_down.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/disable_profile_controller.dart';
import '../../../utils/app_tags.dart';

class StepThree extends StatelessWidget {
  final DisableProfileController controller;
  const StepThree({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            "Please leave us an improvement comment",
            style: TextStyle(
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.sp: 5.sp,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 15.h,
            child: TextField(
              expands: true,
              maxLines:  null,
              // controller: controller.aboutMeController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                hintStyle: const TextStyle(
                  color: Color(0xffC0B4CC),
                  overflow: TextOverflow.clip,
                ),
                filled: true,
                fillColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 12),
                contentPadding: const EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
