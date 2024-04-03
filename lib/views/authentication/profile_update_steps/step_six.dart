import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/update_profile_controller.dart';
import '../../../utils/validators.dart';

class StepSix extends StatelessWidget {
  final UpdateProfileController controller;
  const StepSix({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            "Upload your profile picture",
            style: TextStyle(
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 5.sp,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (ResponsiveWidget.isSmallScreen(context)) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue.withOpacity(0.4)),
                  ),
                  padding: controller.imageFile != null ?
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0):
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                  child: controller.imageFile != null ?
                  Image.file(File(controller.imageFile!.path)):
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 50),
                      InkWell(
                        onTap: () => controller.selectImage(context, ImageSource.camera),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/camera2.png"),
                            const SizedBox(width: 10),
                            const Text(
                              "Selfie photo",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => controller.selectImage(context, ImageSource.camera),
                            child: Image.asset("assets/images/Picture.png"),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => controller.selectImage(context, ImageSource.gallery),
                            child: const Text(
                              "Take a photo",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffCC1262),
                                decoration: TextDecoration.underline,
                                // fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 5.sp,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ) else Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                if(controller.imageFile != null)
                  Expanded(child: Image.network(controller.imageFile!.path))
                else
                  Expanded(
                    child: Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue.withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () => controller.selectImage(context, ImageSource.camera),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/camera2.png"),
                                const SizedBox(width: 10),
                                Text(
                                  "Selfie photo",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 4.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => controller.selectImage(context, ImageSource.gallery),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/Picture.png"),
                                const SizedBox(width: 10),
                                Text(
                                  "Take a photo",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xffCC1262),
                                    fontSize: 4.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              if(kIsWeb) {
                controller.updateUserAdditionalInfo();
              } else {
                if(controller.imageFile != null) {
                  controller.updateUserAdditionalInfo();
                } else {
                  showShortToast("Profile picture is required");
                }
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff27B2CC),
              ),
              padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.0.h),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
