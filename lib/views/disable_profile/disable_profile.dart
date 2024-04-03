import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/custom_stepper.dart';
import '../../Widgets/responsive_widget.dart';
import '../../Widgets/styles.dart';
import '../../controllers/disable_profile_controller.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/wife_reg_controller.dart';
import '../../widgets/top_bar.dart';
import 'disable_profile_steps/step_one.dart';
import 'disable_profile_steps/step_two.dart';
import 'disable_profile_steps/step_three.dart';

final WifeRegistrationController controller = Get.find<WifeRegistrationController>();

class DisableProfile extends StatelessWidget {
  DisableProfile({super.key});
  var dropDownValue;
  final double _currentValue = 25;
  final RangeValues _currentRange = const RangeValues(20, 40);
  final LanguageController langController = Get.find<LanguageController>();
  final NavigationController navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisableProfileController>(builder: (DisableProfileController controller) {
      return WillPopScope(
        onWillPop: () async {
          navController.previousIndex.value = navController.selectedNavIndex;
          navController.handleNavIndexChanged(3);
          return false;
        },
        child: SafeArea(
          child: Column(
            children: [
              if(ResponsiveWidget.isSmallScreen(context))
                const TopBar(),
              const SizedBox(height: 10),
              Text(
                'Disable Profile',
                style: TextStyle(
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 18: 20,
                  fontFamily: "myFontLight",
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF574667),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 20.0: 12.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: S.innerBoxShadow(),
                  ),
                  child: Column(
                    children: [
                      NumberStepper(
                        onStepTap: (value)=> controller.goTo(value + 1),
                        totalSteps: controller.stepLength.value,
                        width: MediaQuery.of(context).size.width,
                        curStep: controller.currentStep.value,
                        stepCompleteColor: Colors.blue,
                        currentStepColor: const Color(0xffF073C0),
                        inactiveColor: const Color(0xffbababa),
                        lineWidth: 5.5,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if(controller.currentStep.value == 1)
                        StepOne(controller: controller),
                      if(controller.currentStep.value == 2)
                        StepTwo(controller: controller),
                      if(controller.currentStep.value == 3)
                        StepThree(controller: controller),
                      const SizedBox(height: 20),
                      if(controller.currentStep.value < 6)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: controller.currentStep.value > 1 ? () {
                                  controller.goTo(controller.currentStep.value -1);
                                }: null,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: controller.currentStep.value > 1 ? const Color(0xff27B2CC): const Color(0xffC0B4CC),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.0.h),
                                  child: const Text(
                                    'Previous',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.goTo(controller.currentStep.value +1);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xff27B2CC),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.0.h),
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    }
    );
  }
}
