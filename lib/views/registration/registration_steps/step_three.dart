import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/setting_controller.dart';
import 'package:nybal/controllers/wife_reg_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/custom_drop_down.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/setting_controller.dart';
import '../../../models/config_model.dart';
import '../../../models/religion_model.dart';
import '../../../utils/app_tags.dart';
import '../../../widgets/model_drop_down.dart';

class StepThree extends StatelessWidget {
  final WifeRegistrationController controller;
  StepThree({super.key, required this.controller});
  final settingController = Get.find<SettingController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            "Religious commitment",
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
                CustomDropDown(
                  selectedText: controller.selectedIsSheReligious.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isSheReligiousSelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onIsSheReligiousChange(value),
                  options: [AppTags.yes.tr, AppTags.no.tr],
                ),
                const SizedBox(height: 20),
                if(controller.selectedIsSheReligious.value == AppTags.yes.tr)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTags.selectReligion.tr,
                      ),
                      const SizedBox(height: 10),
                      CustomModelDropDown<ReligionModel>(
                        backgroundColor: const Color(0xFFF4F4F4),
                        options: controller.religions,
                        onOptionChange: (selectedReligion) => controller.onReligionChange(selectedReligion),
                        selectedValueColor: controller.isReligionSelected() ?
                        const Color(0xff000000): const Color(0xffC0B4CC),
                        optionLabel: (religion) => religion.name!,
                        selectedValue: controller.selectedReligion,
                        isArrowOnLeft: true,
                        arrowIcon: Icons.arrow_downward,
                        arrowColor: const Color(0xffCC1262),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppTags.doesShePray.tr,
                      ),
                      const SizedBox(height: 10),
                      CustomDropDown(
                        selectedText: controller.selectedDoesShePray.value,
                        backgroundColor: const Color(0xFFF4F4F4),
                        selectedValueColor: controller.isDoesShePraySelected() ?
                        const Color(0xff000000): const Color(0xffC0B4CC),
                        onOptionChange: (value) => controller.onDoesShePrayChange(value),
                        options: [AppTags.yes.tr, AppTags.no.tr],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                CustomDropDown(
                  selectedText: controller.selectedDoesSheWearHijab.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isDoYouWearHijabSelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onDoesSheWearHijabChange(value),
                  options: [AppTags.yes.tr, AppTags.no.tr],
                ),
                const SizedBox(height: 20),
                CustomDropDown(
                  selectedText: controller.selectedEthnicity.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isEthnicitySelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onEthnicityChange(value),
                  options: [
                    AppTags.caucasianOrEuropean.tr,
                    AppTags.african.tr,
                    AppTags.africanAmericanBlack.tr,
                    AppTags.asian.tr,
                    AppTags.hispanicOrLatinx.tr,
                    AppTags.nativeAmericanOrIndigenous.tr,
                    AppTags.middleEastern.tr,
                    AppTags.pacificIslander.tr,
                    AppTags.southAsian.tr,
                    AppTags.southeastAsian.tr,
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Text(
            "Study and work",
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
                CustomDropDown(
                  selectedText: controller.selectedPhysicalCondition.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isPhysicalConditionSelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onPhysicalConditionChange(value),
                  options: [AppTags.fat.tr, AppTags.smart.tr, AppTags.skinny.tr, AppTags.healthy.tr],
                ),
                const SizedBox(height: 20),
                if(settingController.educationsList.isNotEmpty)
                  CustomModelDropDown<Educations>(
                    backgroundColor: const Color(0xFFF4F4F4),
                    options: settingController.educationsList,
                    onOptionChange: (selectedEducation) => controller.onEducationChange(selectedEducation),
                    selectedValueColor: controller.isEducationSelected() ?
                    const Color(0xff000000): const Color(0xffC0B4CC),
                    optionLabel: (education) => education.title!,
                    selectedValue: controller.selectedEducation,
                    isArrowOnLeft: true,
                    arrowIcon: Icons.arrow_downward,
                    arrowColor: const Color(0xffCC1262),
                  ),
                // const SizedBox(height: 20),
                // CustomDropDown(
                //   selectedText: "Do you have a job?",
                //   backgroundColor: const Color(0xFFF4F4F4),
                //   selectedValueColor: const Color(0xffC0B4CC),
                //   onOptionChange: (value) {
                //     print(value);
                //   },
                //   options: [AppTags.yes.tr, AppTags.no.tr],
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
