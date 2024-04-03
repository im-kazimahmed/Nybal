import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/custom_checkbox.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/disable_profile_controller.dart';

class StepOne extends StatelessWidget {
  final DisableProfileController controller;
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
              "Before you go, why not try one of the following options?",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomCheckBox(
                      alignment: MainAxisAlignment.end,
                      text: "Start from scratch",
                      textColor: const Color(0xffC0B4CC),
                      checkBoxValue: controller.startFromScratch.value,
                      onChangedFunction: (value){
                        controller.onStartFromScratchChange(value);
                      },
                      activeColor: Colors.deepPurple,
                      borderColor: Colors.grey,
                      flipPosition: true,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomCheckBox(
                      alignment: MainAxisAlignment.end,
                      text: "Silent mode",
                      textColor: const Color(0xffC0B4CC),
                      checkBoxValue: controller.silentMode.value,
                      onChangedFunction: (value){
                        controller.onSilentModeChange(value);
                      },
                      activeColor: Colors.deepPurple,
                      borderColor: Colors.grey,
                      flipPosition: true,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomCheckBox(
                      alignment: MainAxisAlignment.end,
                      text: "Take some time",
                      textColor: const Color(0xffC0B4CC),
                      checkBoxValue: controller.takeSomeTime.value,
                      onChangedFunction: (value){
                        controller.onTakeSomeTimeChange(value);
                      },
                      activeColor: Colors.deepPurple,
                      borderColor: Colors.grey,
                      flipPosition: true,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomCheckBox(
                      alignment: MainAxisAlignment.end,
                      text: "Improve your privacy",
                      textColor: const Color(0xffC0B4CC),
                      checkBoxValue: controller.improvePrivacy.value,
                      onChangedFunction: (value){
                        controller.onImprovePrivacyChange(value);
                      },
                      activeColor: Colors.deepPurple,
                      borderColor: Colors.grey,
                      flipPosition: true,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomCheckBox(
                      alignment: MainAxisAlignment.end,
                      text: "Delete your account",
                      textColor: const Color(0xffC0B4CC),
                      checkBoxValue: controller.deleteAccount.value,
                      onChangedFunction: (value){
                        controller.onDeleteAccountChange(value);
                      },
                      activeColor: Colors.deepPurple,
                      borderColor: Colors.grey,
                      flipPosition: true,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
