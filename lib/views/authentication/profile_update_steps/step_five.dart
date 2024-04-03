import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/custom_checkbox.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/update_profile_controller.dart';

class StepFive extends StatelessWidget {
  final UpdateProfileController controller;
  const StepFive({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            "Confidential data",
            style: TextStyle(
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.sp: 5.sp,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TextField(
                  controller: controller.phoneController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
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
                  controller: controller.fullNameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Enter your full name',
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
                const SizedBox(height: 10),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         children:[
                //           if(!ResponsiveWidget.isSmallScreen(context))
                //             const SizedBox(height: 20),
                //           Text("I have read the terms and conditions of use and agree to all of them",
                //             style: TextStyle(
                //               color: const Color(0xffC0B4CC),
                //               fontSize: ResponsiveWidget.isSmallScreen(context) ? 7.sp: 4.sp,
                //             ),
                //             textAlign: TextAlign.end,
                //           ),
                //         ],
                //       ),
                //     ),
                //     // CustomCheckBox(
                //     //   alignment: MainAxisAlignment.end,
                //     //   textSize: 7.sp,
                //     //   checkBoxValue: controller.termsAndConditions.value,
                //     //   onChangedFunction: (value){
                //     //     controller.onTermsAndConditionChange(value);
                //     //   },
                //     //   activeColor: Colors.deepPurple,
                //     //   borderColor: Colors.grey,
                //     //   flipPosition: true,
                //     // ),
                //   ],
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
