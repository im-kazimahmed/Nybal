import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/wife_reg_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/custom_drop_down.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../utils/app_tags.dart';

class StepFour extends StatelessWidget {
  final WifeRegistrationController controller;
  const StepFour({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            AppTags.specificationsOfYourPartnerThatYouWantToRelateTo.tr,
            style: TextStyle(
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.sp: 5.sp,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 20.h,
            child: TextField(
              expands: true,
              maxLines:  null,
              controller: controller.partnerSpecsController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: AppTags.pleaseWriteInASeriousManner.tr,
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
          const SizedBox(height: 20),
          const Text(
            "Date of birth",
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.dobController,
            readOnly: true,
            onTap: () {
              controller.selectDate(context);
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Enter her date of birth',
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
        ],
      ),
    );
  }
}
