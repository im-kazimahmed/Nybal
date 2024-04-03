import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/custom_checkbox.dart';
import '../../../Widgets/custom_drop_down.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/disable_profile_controller.dart';

class StepTwo extends StatelessWidget {
  final DisableProfileController controller;
  const StepTwo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 0.0: 4.w),
          child: Text(
            "Why have you decided to leave Nybal?",
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
                    text: "I’m not single anymore",
                    textColor: const Color(0xffC0B4CC),
                    checkBoxValue: controller.imNotSingleAnyMore.value,
                    onChangedFunction: (value){
                      controller.onImNotSingleAnymoreChange(value);
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
                    text: "The page not working properly",
                    textColor: const Color(0xffC0B4CC),
                    checkBoxValue: controller.pageNotWorkingProperly.value,
                    onChangedFunction: (value){
                      controller.onPageNotWorkingChange(value);
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
                    text: "I don´t like the page",
                    textColor: const Color(0xffC0B4CC),
                    checkBoxValue: controller.iDontLikeThePage.value,
                    onChangedFunction: (value){
                      controller.onIDontLikeThePageChange(value);
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
                    text: "I want to start from scratch",
                    textColor: const Color(0xffC0B4CC),
                    checkBoxValue: controller.iWantToStartFromScratch.value,
                    onChangedFunction: (value){
                      controller.onIWantToStartFromScratchChange(value);
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
                    text: "I’m looking for something different",
                    textColor: const Color(0xffC0B4CC),
                    checkBoxValue: controller.imLookingSomethingDifferent.value,
                    onChangedFunction: (value){
                      controller.onLookingSomethingDifferentChange(value);
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
    );
  }
}
